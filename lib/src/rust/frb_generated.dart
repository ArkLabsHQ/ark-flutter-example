// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api.dart';
import 'api/ark_api.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'logger.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {
    await api.crateApiInitApp();
  }

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.9.0';

  @override
  int get rustContentHash => 2080225858;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'rust_lib_ark_flutter',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  Future<Addresses> crateApiArkApiAddress();

  Future<Balance> crateApiArkApiBalance();

  Future<Info> crateApiArkApiInformation();

  Future<void> crateApiInitApp();

  Stream<LogEntry> crateApiInitLogging();

  Future<String> crateApiArkApiLoadExistingWallet(
      {required String dataDir,
      required String network,
      required String esplora,
      required String server});

  Future<String> crateApiArkApiNsec({required String dataDir});

  Future<void> crateApiArkApiResetWallet({required String dataDir});

  Future<String> crateApiArkApiRestoreWallet(
      {required String nsec,
      required String dataDir,
      required String network,
      required String esplora,
      required String server});

  Future<String> crateApiArkApiSend(
      {required String address, required BigInt amountSats});

  Future<void> crateApiArkApiSettle();

  Future<String> crateApiArkApiSetupNewWallet(
      {required String dataDir,
      required String network,
      required String esplora,
      required String server});

  Future<List<Transaction>> crateApiArkApiTxHistory();

  Future<bool> crateApiArkApiWalletExists({required String dataDir});
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  Future<Addresses> crateApiArkApiAddress() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 1, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_addresses,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiAddressConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiAddressConstMeta => const TaskConstMeta(
        debugName: "address",
        argNames: [],
      );

  @override
  Future<Balance> crateApiArkApiBalance() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 2, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_balance,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiBalanceConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiBalanceConstMeta => const TaskConstMeta(
        debugName: "balance",
        argNames: [],
      );

  @override
  Future<Info> crateApiArkApiInformation() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_info,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiInformationConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiInformationConstMeta => const TaskConstMeta(
        debugName: "information",
        argNames: [],
      );

  @override
  Future<void> crateApiInitApp() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 4, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  @override
  Stream<LogEntry> crateApiInitLogging() {
    final sink = RustStreamSink<LogEntry>();
    unawaited(handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_StreamSink_log_entry_Sse(sink, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 5, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiInitLoggingConstMeta,
      argValues: [sink],
      apiImpl: this,
    )));
    return sink.stream;
  }

  TaskConstMeta get kCrateApiInitLoggingConstMeta => const TaskConstMeta(
        debugName: "init_logging",
        argNames: ["sink"],
      );

  @override
  Future<String> crateApiArkApiLoadExistingWallet(
      {required String dataDir,
      required String network,
      required String esplora,
      required String server}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dataDir, serializer);
        sse_encode_String(network, serializer);
        sse_encode_String(esplora, serializer);
        sse_encode_String(server, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 6, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiLoadExistingWalletConstMeta,
      argValues: [dataDir, network, esplora, server],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiLoadExistingWalletConstMeta =>
      const TaskConstMeta(
        debugName: "load_existing_wallet",
        argNames: ["dataDir", "network", "esplora", "server"],
      );

  @override
  Future<String> crateApiArkApiNsec({required String dataDir}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dataDir, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 7, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiNsecConstMeta,
      argValues: [dataDir],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiNsecConstMeta => const TaskConstMeta(
        debugName: "nsec",
        argNames: ["dataDir"],
      );

  @override
  Future<void> crateApiArkApiResetWallet({required String dataDir}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dataDir, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 8, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiResetWalletConstMeta,
      argValues: [dataDir],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiResetWalletConstMeta => const TaskConstMeta(
        debugName: "reset_wallet",
        argNames: ["dataDir"],
      );

  @override
  Future<String> crateApiArkApiRestoreWallet(
      {required String nsec,
      required String dataDir,
      required String network,
      required String esplora,
      required String server}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(nsec, serializer);
        sse_encode_String(dataDir, serializer);
        sse_encode_String(network, serializer);
        sse_encode_String(esplora, serializer);
        sse_encode_String(server, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 9, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiRestoreWalletConstMeta,
      argValues: [nsec, dataDir, network, esplora, server],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiRestoreWalletConstMeta =>
      const TaskConstMeta(
        debugName: "restore_wallet",
        argNames: ["nsec", "dataDir", "network", "esplora", "server"],
      );

  @override
  Future<String> crateApiArkApiSend(
      {required String address, required BigInt amountSats}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(address, serializer);
        sse_encode_u_64(amountSats, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 10, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiSendConstMeta,
      argValues: [address, amountSats],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiSendConstMeta => const TaskConstMeta(
        debugName: "send",
        argNames: ["address", "amountSats"],
      );

  @override
  Future<void> crateApiArkApiSettle() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 11, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiSettleConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiSettleConstMeta => const TaskConstMeta(
        debugName: "settle",
        argNames: [],
      );

  @override
  Future<String> crateApiArkApiSetupNewWallet(
      {required String dataDir,
      required String network,
      required String esplora,
      required String server}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dataDir, serializer);
        sse_encode_String(network, serializer);
        sse_encode_String(esplora, serializer);
        sse_encode_String(server, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 12, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiSetupNewWalletConstMeta,
      argValues: [dataDir, network, esplora, server],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiSetupNewWalletConstMeta =>
      const TaskConstMeta(
        debugName: "setup_new_wallet",
        argNames: ["dataDir", "network", "esplora", "server"],
      );

  @override
  Future<List<Transaction>> crateApiArkApiTxHistory() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 13, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_transaction,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiTxHistoryConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiTxHistoryConstMeta => const TaskConstMeta(
        debugName: "tx_history",
        argNames: [],
      );

  @override
  Future<bool> crateApiArkApiWalletExists({required String dataDir}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(dataDir, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 14, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_bool,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiArkApiWalletExistsConstMeta,
      argValues: [dataDir],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiArkApiWalletExistsConstMeta => const TaskConstMeta(
        debugName: "wallet_exists",
        argNames: ["dataDir"],
      );

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return AnyhowException(raw as String);
  }

  @protected
  RustStreamSink<LogEntry> dco_decode_StreamSink_log_entry_Sse(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    throw UnimplementedError();
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  Addresses dco_decode_addresses(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return Addresses(
      boarding: dco_decode_String(arr[0]),
      offchain: dco_decode_String(arr[1]),
      bip21: dco_decode_String(arr[2]),
    );
  }

  @protected
  Balance dco_decode_balance(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 1)
      throw Exception('unexpected arr length: expect 1 but see ${arr.length}');
    return Balance(
      offchain: dco_decode_offchain_balance(arr[0]),
    );
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  PlatformInt64 dco_decode_box_autoadd_i_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_i_64(raw);
  }

  @protected
  PlatformInt64 dco_decode_i_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeI64(raw);
  }

  @protected
  Info dco_decode_info(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return Info(
      serverPk: dco_decode_String(arr[0]),
      network: dco_decode_String(arr[1]),
    );
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  List<Transaction> dco_decode_list_transaction(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_transaction).toList();
  }

  @protected
  LogEntry dco_decode_log_entry(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 7)
      throw Exception('unexpected arr length: expect 7 but see ${arr.length}');
    return LogEntry(
      msg: dco_decode_String(arr[0]),
      target: dco_decode_String(arr[1]),
      level: dco_decode_String(arr[2]),
      file: dco_decode_String(arr[3]),
      line: dco_decode_String(arr[4]),
      modulePath: dco_decode_String(arr[5]),
      data: dco_decode_String(arr[6]),
    );
  }

  @protected
  OffchainBalance dco_decode_offchain_balance(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return OffchainBalance(
      pendingSats: dco_decode_u_64(arr[0]),
      confirmedSats: dco_decode_u_64(arr[1]),
      totalSats: dco_decode_u_64(arr[2]),
    );
  }

  @protected
  PlatformInt64? dco_decode_opt_box_autoadd_i_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw == null ? null : dco_decode_box_autoadd_i_64(raw);
  }

  @protected
  Transaction dco_decode_transaction(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    switch (raw[0]) {
      case 0:
        return Transaction_Boarding(
          txid: dco_decode_String(raw[1]),
          amountSats: dco_decode_u_64(raw[2]),
          confirmedAt: dco_decode_opt_box_autoadd_i_64(raw[3]),
        );
      case 1:
        return Transaction_Round(
          txid: dco_decode_String(raw[1]),
          amountSats: dco_decode_i_64(raw[2]),
          createdAt: dco_decode_i_64(raw[3]),
        );
      case 2:
        return Transaction_Redeem(
          txid: dco_decode_String(raw[1]),
          amountSats: dco_decode_i_64(raw[2]),
          isSettled: dco_decode_bool(raw[3]),
          createdAt: dco_decode_i_64(raw[4]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  @protected
  BigInt dco_decode_u_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_String(deserializer);
    return AnyhowException(inner);
  }

  @protected
  RustStreamSink<LogEntry> sse_decode_StreamSink_log_entry_Sse(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    throw UnimplementedError('Unreachable ()');
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  Addresses sse_decode_addresses(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_boarding = sse_decode_String(deserializer);
    var var_offchain = sse_decode_String(deserializer);
    var var_bip21 = sse_decode_String(deserializer);
    return Addresses(
        boarding: var_boarding, offchain: var_offchain, bip21: var_bip21);
  }

  @protected
  Balance sse_decode_balance(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_offchain = sse_decode_offchain_balance(deserializer);
    return Balance(offchain: var_offchain);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  PlatformInt64 sse_decode_box_autoadd_i_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_i_64(deserializer));
  }

  @protected
  PlatformInt64 sse_decode_i_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getPlatformInt64();
  }

  @protected
  Info sse_decode_info(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_serverPk = sse_decode_String(deserializer);
    var var_network = sse_decode_String(deserializer);
    return Info(serverPk: var_serverPk, network: var_network);
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  List<Transaction> sse_decode_list_transaction(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <Transaction>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_transaction(deserializer));
    }
    return ans_;
  }

  @protected
  LogEntry sse_decode_log_entry(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_msg = sse_decode_String(deserializer);
    var var_target = sse_decode_String(deserializer);
    var var_level = sse_decode_String(deserializer);
    var var_file = sse_decode_String(deserializer);
    var var_line = sse_decode_String(deserializer);
    var var_modulePath = sse_decode_String(deserializer);
    var var_data = sse_decode_String(deserializer);
    return LogEntry(
        msg: var_msg,
        target: var_target,
        level: var_level,
        file: var_file,
        line: var_line,
        modulePath: var_modulePath,
        data: var_data);
  }

  @protected
  OffchainBalance sse_decode_offchain_balance(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_pendingSats = sse_decode_u_64(deserializer);
    var var_confirmedSats = sse_decode_u_64(deserializer);
    var var_totalSats = sse_decode_u_64(deserializer);
    return OffchainBalance(
        pendingSats: var_pendingSats,
        confirmedSats: var_confirmedSats,
        totalSats: var_totalSats);
  }

  @protected
  PlatformInt64? sse_decode_opt_box_autoadd_i_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    if (sse_decode_bool(deserializer)) {
      return (sse_decode_box_autoadd_i_64(deserializer));
    } else {
      return null;
    }
  }

  @protected
  Transaction sse_decode_transaction(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var tag_ = sse_decode_i_32(deserializer);
    switch (tag_) {
      case 0:
        var var_txid = sse_decode_String(deserializer);
        var var_amountSats = sse_decode_u_64(deserializer);
        var var_confirmedAt = sse_decode_opt_box_autoadd_i_64(deserializer);
        return Transaction_Boarding(
            txid: var_txid,
            amountSats: var_amountSats,
            confirmedAt: var_confirmedAt);
      case 1:
        var var_txid = sse_decode_String(deserializer);
        var var_amountSats = sse_decode_i_64(deserializer);
        var var_createdAt = sse_decode_i_64(deserializer);
        return Transaction_Round(
            txid: var_txid,
            amountSats: var_amountSats,
            createdAt: var_createdAt);
      case 2:
        var var_txid = sse_decode_String(deserializer);
        var var_amountSats = sse_decode_i_64(deserializer);
        var var_isSettled = sse_decode_bool(deserializer);
        var var_createdAt = sse_decode_i_64(deserializer);
        return Transaction_Redeem(
            txid: var_txid,
            amountSats: var_amountSats,
            isSettled: var_isSettled,
            createdAt: var_createdAt);
      default:
        throw UnimplementedError('');
    }
  }

  @protected
  BigInt sse_decode_u_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.message, serializer);
  }

  @protected
  void sse_encode_StreamSink_log_entry_Sse(
      RustStreamSink<LogEntry> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(
        self.setupAndSerialize(
            codec: SseCodec(
          decodeSuccessData: sse_decode_log_entry,
          decodeErrorData: sse_decode_AnyhowException,
        )),
        serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_addresses(Addresses self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.boarding, serializer);
    sse_encode_String(self.offchain, serializer);
    sse_encode_String(self.bip21, serializer);
  }

  @protected
  void sse_encode_balance(Balance self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_offchain_balance(self.offchain, serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_box_autoadd_i_64(
      PlatformInt64 self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_64(self, serializer);
  }

  @protected
  void sse_encode_i_64(PlatformInt64 self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putPlatformInt64(self);
  }

  @protected
  void sse_encode_info(Info self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.serverPk, serializer);
    sse_encode_String(self.network, serializer);
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_list_transaction(
      List<Transaction> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_transaction(item, serializer);
    }
  }

  @protected
  void sse_encode_log_entry(LogEntry self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.msg, serializer);
    sse_encode_String(self.target, serializer);
    sse_encode_String(self.level, serializer);
    sse_encode_String(self.file, serializer);
    sse_encode_String(self.line, serializer);
    sse_encode_String(self.modulePath, serializer);
    sse_encode_String(self.data, serializer);
  }

  @protected
  void sse_encode_offchain_balance(
      OffchainBalance self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_u_64(self.pendingSats, serializer);
    sse_encode_u_64(self.confirmedSats, serializer);
    sse_encode_u_64(self.totalSats, serializer);
  }

  @protected
  void sse_encode_opt_box_autoadd_i_64(
      PlatformInt64? self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    sse_encode_bool(self != null, serializer);
    if (self != null) {
      sse_encode_box_autoadd_i_64(self, serializer);
    }
  }

  @protected
  void sse_encode_transaction(Transaction self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    switch (self) {
      case Transaction_Boarding(
          txid: final txid,
          amountSats: final amountSats,
          confirmedAt: final confirmedAt
        ):
        sse_encode_i_32(0, serializer);
        sse_encode_String(txid, serializer);
        sse_encode_u_64(amountSats, serializer);
        sse_encode_opt_box_autoadd_i_64(confirmedAt, serializer);
      case Transaction_Round(
          txid: final txid,
          amountSats: final amountSats,
          createdAt: final createdAt
        ):
        sse_encode_i_32(1, serializer);
        sse_encode_String(txid, serializer);
        sse_encode_i_64(amountSats, serializer);
        sse_encode_i_64(createdAt, serializer);
      case Transaction_Redeem(
          txid: final txid,
          amountSats: final amountSats,
          isSettled: final isSettled,
          createdAt: final createdAt
        ):
        sse_encode_i_32(2, serializer);
        sse_encode_String(txid, serializer);
        sse_encode_i_64(amountSats, serializer);
        sse_encode_bool(isSettled, serializer);
        sse_encode_i_64(createdAt, serializer);
    }
  }

  @protected
  void sse_encode_u_64(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}
