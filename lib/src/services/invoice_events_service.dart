import 'dart:async';

import 'package:ark_flutter/src/logger/logger.dart';
import 'package:ark_flutter/src/rust/api/ark_api.dart';
import 'package:flutter/widgets.dart';

/// Global navigator key used by the payment overlay to navigate from outside
/// the route tree.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

/// Listens to lightning invoice events from the Rust monitor and re-broadcasts
/// them to UI consumers via [stream]. Call [start] once after the wallet has
/// been initialized.
class InvoiceEventsService {
  InvoiceEventsService._();
  static final InvoiceEventsService instance = InvoiceEventsService._();

  StreamSubscription<InvoiceEvent>? _sub;
  final StreamController<InvoiceEvent> _controller =
      StreamController<InvoiceEvent>.broadcast();

  /// Broadcast stream of invoice events. Multiple widgets can subscribe.
  Stream<InvoiceEvent> get stream => _controller.stream;

  /// Bumped whenever consumers should re-fetch wallet data (balance, tx
  /// history). Dashboard listens and triggers its own refresh.
  final ValueNotifier<int> walletRefresh = ValueNotifier<int>(0);
  void requestWalletRefresh() => walletRefresh.value++;

  void start() {
    if (_sub != null) return;
    _sub = invoiceEvents().listen(
      (event) {
        logger.i(
            'Invoice event: ${event.status} swap=${event.swapId} sats=${event.amountSats}');
        _controller.add(event);
      },
      onError: (e, st) {
        logger.e('Invoice events stream error: $e');
      },
    );
  }

  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    await _controller.close();
  }
}
