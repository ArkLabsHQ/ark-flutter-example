import 'package:ark_flutter/src/rust/api/ark_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ark_flutter/src/logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class ReceiveScreen extends StatefulWidget {
  final String aspId;

  const ReceiveScreen({
    super.key,
    required this.aspId,
  });

  @override
  ReceiveScreenState createState() => ReceiveScreenState();
}

class ReceiveScreenState extends State<ReceiveScreen> {
  String? _error;

  String _bip21Address = "";
  String _btcAddress = "";
  String _arkAddress = "";

  final TextEditingController _amountController = TextEditingController();

  bool _showCopyMenu = false;

  // Which address is rendered in the QR code. BIP21 is the default unified URL.
  String _selectedType = 'BIP21';

  // Lightning invoice state
  String? _lightningInvoice;
  String? _lightningError;
  bool _lightningLoading = false;

  // Amount that produced the currently-rendered QR. When the input differs,
  // the QR is stale (fade it to signal the user must Regenerate).
  BigInt? _generatedAmount;
  bool _hasGenerated = false;

  // Track which addresses have been copied (for showing checkmarks)
  final Map<String, bool> _copiedAddresses = {
    'BIP21': false,
    'BTC': false,
    'Ark': false,
    'Lightning': false,
  };

  // Timers for resetting the checkmarks
  final Map<String, Timer?> _checkmarkTimers = {
    'BIP21': null,
    'BTC': null,
    'Ark': null,
    'Lightning': null,
  };

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    try {
      final sats = BigInt.tryParse(_amountController.text.trim());
      final addresses = await address(amountSats: sats);
      setState(() {
        _bip21Address = addresses.bip21;
        _arkAddress = addresses.offchain;
        _btcAddress = addresses.boarding;
        _hasGenerated = true;
        _generatedAmount = sats;
      });
    } catch (e) {
      logger.e("Error fetching addresses: $e");
      setState(() {
        _error = e.toString();
      });
    } finally {}
  }

  bool get _isStale {
    if (!_hasGenerated) return false;
    final current = BigInt.tryParse(_amountController.text.trim());
    return current != _generatedAmount;
  }

  void _onAmountChanged(String _) {
    // Don't auto-refresh — user explicitly taps Regenerate. Just clear any
    // stale LN invoice so we don't display one for the wrong amount.
    if (_lightningInvoice != null ||
        _lightningError != null ||
        _lightningLoading) {
      setState(() {
        _lightningInvoice = null;
        _lightningError = null;
        _lightningLoading = false;
        if (_selectedType == 'Lightning') _selectedType = 'BIP21';
      });
    } else {
      // Trigger a rebuild so the suffix clear-icon visibility updates.
      setState(() {});
    }
  }

  Future<void> _regenerate() async {
    await _fetchAddresses();
    final sats = BigInt.tryParse(_amountController.text.trim());
    if (sats == null || sats == BigInt.zero) return;
    setState(() {
      _lightningLoading = true;
      _lightningError = null;
    });
    await _fetchLightningInvoice(sats);
  }

  Future<void> _fetchLightningInvoice(BigInt sats) async {
    try {
      final invoice = await lightningInvoice(amountSats: sats);
      if (!mounted) return;
      // Drop result if the amount changed while we were fetching.
      if (BigInt.tryParse(_amountController.text.trim()) != sats) return;
      setState(() {
        _lightningInvoice = invoice;
        _lightningError = null;
        _lightningLoading = false;
      });
    } catch (e) {
      logger.e("Error generating LN invoice: $e");
      if (!mounted) return;
      if (BigInt.tryParse(_amountController.text.trim()) != sats) return;
      setState(() {
        _lightningInvoice = null;
        _lightningError = e.toString();
        _lightningLoading = false;
      });
    }
  }

  // BIP21 with the LN invoice appended (when available). Wallets can pick
  // their preferred rail (on-chain, ark, or lightning) from the unified URI.
  String get _bip21Display => _lightningInvoice == null
      ? _bip21Address
      : '$_bip21Address&lightning=$_lightningInvoice';

  String get _qrData {
    switch (_selectedType) {
      case 'BTC':
        return _btcAddress;
      case 'Ark':
        return _arkAddress;
      case 'Lightning':
        return _lightningInvoice ?? _bip21Display;
      case 'BIP21':
      default:
        return _bip21Display;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    // Cancel any active timers
    _checkmarkTimers.forEach((key, timer) {
      if (timer != null) {
        timer.cancel();
      }
    });
    super.dispose();
  }

  void _toggleCopyMenu() {
    setState(() {
      _showCopyMenu = !_showCopyMenu;
    });
  }

  void _copyAddress(String address, String type) {
    Clipboard.setData(ClipboardData(text: address));

    // Cancel existing timer if there is one
    if (_checkmarkTimers[type] != null) {
      _checkmarkTimers[type]!.cancel();
    }

    // Show checkmark + update QR to display the selected address
    setState(() {
      _copiedAddresses[type] = true;
      _selectedType = type;
    });

    // Set timer to hide checkmark after 2 seconds
    _checkmarkTimers[type] = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copiedAddresses[type] = false;
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$type address copied to clipboard')),
    );
    logger.i("Copied $type address: $address");
  }

  final GlobalKey _qrKey = GlobalKey();

  Future<void> _handleShare() async {
    try {
      logger.i("Share button pressed");

      // Determine which address to share
      String addressToShare = _bip21Display;
      String addressType = "BIP21";

      // Show sharing options dialog
      final String? selectedType = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[850],
            title: const Text('Share Which Address?',
                style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildShareOption('BIP21 Address', 'BIP21'),
                _buildShareOption('BTC Address', 'BTC'),
                _buildShareOption('Ark Address', 'Ark'),
                if (_lightningInvoice != null)
                  _buildShareOption('Lightning Invoice', 'Lightning'),
                _buildShareOption('QR Code Image', 'QR'),
              ],
            ),
          );
        },
      );

      if (selectedType == null) {
        // User cancelled the dialog
        return;
      }

      switch (selectedType) {
        case 'BIP21':
          addressToShare = _bip21Display;
          addressType = "BIP21";
          break;
        case 'BTC':
          addressToShare = _btcAddress;
          addressType = "BTC";
          break;
        case 'Ark':
          addressToShare = _arkAddress;
          addressType = "Ark";
          break;
        case 'Lightning':
          addressToShare = _lightningInvoice ?? '';
          addressType = "Lightning";
          break;
        case 'QR':
          // Share the QR code as an image
          await _shareQrCodeImage();
          return;
      }

      // Share the text address
      await Share.share(
        addressToShare,
        subject: 'My $addressType Address',
      );

      logger.i("Shared $addressType address: $addressToShare");
    } catch (e) {
      logger.e("Error sharing address: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing: ${e.toString()}')),
      );
    }
  }

  Widget _buildShareOption(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.of(context).pop(value);
      },
    );
  }

  Future<void> _shareQrCodeImage() async {
    try {
      // Capture the QR code as an image
      RenderRepaintBoundary? boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception("Could not find QR code widget");
      }

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception("Could not convert QR code to image");
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Save image to temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      // Share the image
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'My Bitcoin Address QR Code',
      );

      logger.i("Shared QR code image");
    } catch (e) {
      logger.e("Error sharing QR code image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing QR code: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Receive',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[800],
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // QR Code
                  AnimatedOpacity(
                    opacity: _isStale ? 0.35 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: RepaintBoundary(
                      key: _qrKey,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: QrImageView(
                          data: _qrData,
                          version: QrVersions.auto,
                          size: 280.0,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Amount input (sats) — included in BIP21 when set
                  TextField(
                    controller: _amountController,
                    onChanged: _onAmountChanged,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Amount (sats) — optional',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: _amountController.text.isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(Icons.clear,
                                  color: Colors.grey[400], size: 20),
                              onPressed: () {
                                _amountController.clear();
                                _onAmountChanged('');
                              },
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Regenerate button — refreshes addresses and (if amount > 0) LN invoice
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _lightningLoading ? null : _regenerate,
                      icon: _lightningLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.amber),
                              ),
                            )
                          : const Icon(Icons.refresh, color: Colors.amber),
                      label: Text(
                        _lightningInvoice == null ? 'Generate' : 'Regenerate',
                        style: const TextStyle(color: Colors.amber),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.amber.shade700),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Copy address dropdown button
                  InkWell(
                    onTap: _toggleCopyMenu,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.vertical(
                          top: const Radius.circular(8),
                          bottom: _showCopyMenu
                              ? const Radius.circular(0)
                              : const Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Copy address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            _showCopyMenu
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Address options
                  if (_showCopyMenu) _buildAddressOptions(),

                  const SizedBox(height: 16),

                  if (_error != null)
                    const Text(
                      'Error loading addresses',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ],
              ),
            ),
          ),

          // Share button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleShare,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[500],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'SHARE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          const Divider(height: 1, color: Colors.grey),

          // BIP21 Address (unified — includes lightning invoice when present)
          _buildAddressOption(
            label: 'BIP21',
            address: _bip21Display,
            onTap: () => _copyAddress(_bip21Display, 'BIP21'),
            isCopied: _copiedAddresses['BIP21']!,
          ),

          const Divider(
              height: 1, indent: 16, endIndent: 16, color: Colors.grey),

          // BTC Address
          _buildAddressOption(
            label: 'BTC address',
            address: _btcAddress,
            onTap: () => _copyAddress(_btcAddress, 'BTC'),
            isCopied: _copiedAddresses['BTC']!,
          ),

          const Divider(
              height: 1, indent: 16, endIndent: 16, color: Colors.grey),

          // Ark Address
          _buildAddressOption(
            label: 'Ark address',
            address: _arkAddress,
            onTap: () => _copyAddress(_arkAddress, 'Ark'),
            isCopied: _copiedAddresses['Ark']!,
          ),

          // Lightning invoice — only when an amount is set.
          if (_lightningLoading ||
              _lightningInvoice != null ||
              _lightningError != null) ...[
            const Divider(
                height: 1, indent: 16, endIndent: 16, color: Colors.grey),
            _buildLightningOption(),
          ],
        ],
      ),
    );
  }

  Widget _buildLightningOption() {
    if (_lightningLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            SizedBox(width: 12),
            Text('Generating lightning invoice…',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      );
    }
    if (_lightningError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lightning',
                style: TextStyle(color: Colors.grey[400], fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              _lightningError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }
    return _buildAddressOption(
      label: 'Lightning invoice',
      address: _lightningInvoice!,
      onTap: () => _copyAddress(_lightningInvoice!, 'Lightning'),
      isCopied: _copiedAddresses['Lightning']!,
    );
  }

  Widget _buildAddressOption({
    required String label,
    required String address,
    required VoidCallback onTap,
    required bool isCopied,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            isCopied
                ? const Icon(Icons.check_circle, color: Colors.amber, size: 24)
                : Icon(Icons.copy, color: Colors.grey[400], size: 24),
          ],
        ),
      ),
    );
  }
}
