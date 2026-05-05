import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:ark_flutter/src/rust/api/ark_api.dart';
import 'package:ark_flutter/src/services/invoice_events_service.dart';
import 'package:flutter/material.dart';

/// Full-screen modal celebration shown above every route when a lightning
/// invoice is paid. Two actions: dismiss (stay on current screen) or go home
/// (pop to root + trigger wallet refresh).
class PaymentNotificationOverlay extends StatefulWidget {
  const PaymentNotificationOverlay({super.key});

  @override
  State<PaymentNotificationOverlay> createState() =>
      _PaymentNotificationOverlayState();
}

class _PaymentNotificationOverlayState extends State<PaymentNotificationOverlay>
    with TickerProviderStateMixin {
  StreamSubscription<InvoiceEvent>? _sub;
  StreamSubscription<PaymentEvent>? _paymentSub;
  final Queue<_NotificationItem> _queue = Queue<_NotificationItem>();
  _NotificationItem? _current;

  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 220),
  );
  late final Animation<double> _fade =
      CurvedAnimation(parent: _enter, curve: Curves.easeOut);
  late final Animation<double> _scale = Tween<double>(
    begin: 0.65,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutBack));

  late final AnimationController _glow = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _sub = InvoiceEventsService.instance.stream.listen(_onInvoice);
    _paymentSub =
        InvoiceEventsService.instance.paymentStream.listen(_onPayment);
  }

  void _onInvoice(InvoiceEvent event) {
    if (event.status != InvoiceEventStatus.paid) return;
    _enqueue(_NotificationItem.lightning(event.amountSats));
  }

  void _onPayment(PaymentEvent event) {
    _enqueue(_NotificationItem.ark(event.amountSats));
  }

  void _enqueue(_NotificationItem item) {
    _queue.add(item);
    if (_current == null) _showNext();
  }

  void _showNext() {
    if (_queue.isEmpty) {
      setState(() => _current = null);
      return;
    }
    setState(() => _current = _queue.removeFirst());
    _enter.forward(from: 0);
  }

  Future<void> _close() async {
    if (!mounted) return;
    await _enter.reverse();
    if (!mounted) return;
    _showNext();
  }

  Future<void> _goHome() async {
    final navigator = appNavigatorKey.currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
    }
    InvoiceEventsService.instance.requestWalletRefresh();
    await _close();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _paymentSub?.cancel();
    _enter.dispose();
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = _current;
    if (item == null) return const SizedBox.shrink();

    return Positioned.fill(
      child: FadeTransition(
        opacity: _fade,
        child: Stack(
          children: [
            // Dimmed, blurred backdrop. Tap-outside doesn't dismiss — the user
            // must explicitly choose Close or Home.
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withValues(alpha: 0.55)),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: _scale,
                child: _Card(
                  item: item,
                  glow: _glow,
                  onClose: _close,
                  onHome: _goHome,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _NotificationKind { lightning, ark }

class _NotificationItem {
  final BigInt amountSats;
  final _NotificationKind kind;

  const _NotificationItem(this.amountSats, this.kind);

  factory _NotificationItem.lightning(BigInt sats) =>
      _NotificationItem(sats, _NotificationKind.lightning);

  factory _NotificationItem.ark(BigInt sats) =>
      _NotificationItem(sats, _NotificationKind.ark);

  String get sourceLabel => switch (kind) {
        _NotificationKind.lightning => 'via Lightning',
        _NotificationKind.ark => 'via Arkade',
      };

  IconData get icon => switch (kind) {
        _NotificationKind.lightning => Icons.bolt,
        _NotificationKind.ark => Icons.account_balance_wallet,
      };
}

class _Card extends StatelessWidget {
  const _Card({
    required this.item,
    required this.glow,
    required this.onClose,
    required this.onHome,
  });

  final _NotificationItem item;
  final Animation<double> glow;
  final VoidCallback onClose;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: glow,
          builder: (context, child) {
            final t = glow.value;
            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B1A12), Color(0xFF22200F)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.45 + 0.35 * t),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.18 + 0.22 * t),
                    blurRadius: 24 + 18 * t,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulsingIcon(glow: glow, icon: item.icon),
                const SizedBox(height: 20),
                const Text(
                  'Payment received',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '+',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: _formatSats(item.amountSats),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const TextSpan(
                        text: ' sats',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.sourceLabel,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onClose,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[700]!),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('CLOSE',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, letterSpacing: 1)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onHome,
                        icon: const Icon(Icons.home, size: 18),
                        label: const Text('HOME',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, letterSpacing: 1)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[500],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatSats(BigInt sats) {
    final s = sats.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _PulsingIcon extends StatelessWidget {
  const _PulsingIcon({required this.glow, required this.icon});

  final Animation<double> glow;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (context, _) {
        final t = glow.value;
        return Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.amber.withValues(alpha: 0.25 + 0.15 * t),
                Colors.amber.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.withValues(alpha: 0.18),
                border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.5 + 0.4 * t),
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: Colors.amber, size: 36),
            ),
          ),
        );
      },
    );
  }
}
