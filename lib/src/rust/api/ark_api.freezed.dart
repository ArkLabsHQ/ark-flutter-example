// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ark_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Transaction {
  String get txid => throw _privateConstructorUsedError;
  Object get amountSats => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String txid, BigInt amountSats, int? confirmedAt)
        boarding,
    required TResult Function(String txid, int amountSats, int createdAt)
        commitment,
    required TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)
        redeem,
    required TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)
        ark,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult? Function(String txid, int amountSats, int createdAt)? commitment,
    TResult? Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult? Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult Function(String txid, int amountSats, int createdAt)? commitment,
    TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Transaction_Boarding value) boarding,
    required TResult Function(Transaction_Commitment value) commitment,
    required TResult Function(Transaction_Redeem value) redeem,
    required TResult Function(Transaction_Ark value) ark,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Transaction_Boarding value)? boarding,
    TResult? Function(Transaction_Commitment value)? commitment,
    TResult? Function(Transaction_Redeem value)? redeem,
    TResult? Function(Transaction_Ark value)? ark,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Transaction_Boarding value)? boarding,
    TResult Function(Transaction_Commitment value)? commitment,
    TResult Function(Transaction_Redeem value)? redeem,
    TResult Function(Transaction_Ark value)? ark,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({String txid});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
  }) {
    return _then(_value.copyWith(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Transaction_BoardingImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$Transaction_BoardingImplCopyWith(_$Transaction_BoardingImpl value,
          $Res Function(_$Transaction_BoardingImpl) then) =
      __$$Transaction_BoardingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, BigInt amountSats, int? confirmedAt});
}

/// @nodoc
class __$$Transaction_BoardingImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$Transaction_BoardingImpl>
    implements _$$Transaction_BoardingImplCopyWith<$Res> {
  __$$Transaction_BoardingImplCopyWithImpl(_$Transaction_BoardingImpl _value,
      $Res Function(_$Transaction_BoardingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? amountSats = null,
    Object? confirmedAt = freezed,
  }) {
    return _then(_$Transaction_BoardingImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      amountSats: null == amountSats
          ? _value.amountSats
          : amountSats // ignore: cast_nullable_to_non_nullable
              as BigInt,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$Transaction_BoardingImpl extends Transaction_Boarding {
  const _$Transaction_BoardingImpl(
      {required this.txid, required this.amountSats, this.confirmedAt})
      : super._();

  @override
  final String txid;
  @override
  final BigInt amountSats;
  @override
  final int? confirmedAt;

  @override
  String toString() {
    return 'Transaction.boarding(txid: $txid, amountSats: $amountSats, confirmedAt: $confirmedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Transaction_BoardingImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.amountSats, amountSats) ||
                other.amountSats == amountSats) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txid, amountSats, confirmedAt);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Transaction_BoardingImplCopyWith<_$Transaction_BoardingImpl>
      get copyWith =>
          __$$Transaction_BoardingImplCopyWithImpl<_$Transaction_BoardingImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String txid, BigInt amountSats, int? confirmedAt)
        boarding,
    required TResult Function(String txid, int amountSats, int createdAt)
        commitment,
    required TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)
        redeem,
    required TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)
        ark,
  }) {
    return boarding(txid, amountSats, confirmedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult? Function(String txid, int amountSats, int createdAt)? commitment,
    TResult? Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult? Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
  }) {
    return boarding?.call(txid, amountSats, confirmedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult Function(String txid, int amountSats, int createdAt)? commitment,
    TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
    required TResult orElse(),
  }) {
    if (boarding != null) {
      return boarding(txid, amountSats, confirmedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Transaction_Boarding value) boarding,
    required TResult Function(Transaction_Commitment value) commitment,
    required TResult Function(Transaction_Redeem value) redeem,
    required TResult Function(Transaction_Ark value) ark,
  }) {
    return boarding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Transaction_Boarding value)? boarding,
    TResult? Function(Transaction_Commitment value)? commitment,
    TResult? Function(Transaction_Redeem value)? redeem,
    TResult? Function(Transaction_Ark value)? ark,
  }) {
    return boarding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Transaction_Boarding value)? boarding,
    TResult Function(Transaction_Commitment value)? commitment,
    TResult Function(Transaction_Redeem value)? redeem,
    TResult Function(Transaction_Ark value)? ark,
    required TResult orElse(),
  }) {
    if (boarding != null) {
      return boarding(this);
    }
    return orElse();
  }
}

abstract class Transaction_Boarding extends Transaction {
  const factory Transaction_Boarding(
      {required final String txid,
      required final BigInt amountSats,
      final int? confirmedAt}) = _$Transaction_BoardingImpl;
  const Transaction_Boarding._() : super._();

  @override
  String get txid;
  @override
  BigInt get amountSats;
  int? get confirmedAt;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Transaction_BoardingImplCopyWith<_$Transaction_BoardingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Transaction_CommitmentImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$Transaction_CommitmentImplCopyWith(
          _$Transaction_CommitmentImpl value,
          $Res Function(_$Transaction_CommitmentImpl) then) =
      __$$Transaction_CommitmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, int amountSats, int createdAt});
}

/// @nodoc
class __$$Transaction_CommitmentImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$Transaction_CommitmentImpl>
    implements _$$Transaction_CommitmentImplCopyWith<$Res> {
  __$$Transaction_CommitmentImplCopyWithImpl(
      _$Transaction_CommitmentImpl _value,
      $Res Function(_$Transaction_CommitmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? amountSats = null,
    Object? createdAt = null,
  }) {
    return _then(_$Transaction_CommitmentImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      amountSats: null == amountSats
          ? _value.amountSats
          : amountSats // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Transaction_CommitmentImpl extends Transaction_Commitment {
  const _$Transaction_CommitmentImpl(
      {required this.txid, required this.amountSats, required this.createdAt})
      : super._();

  @override
  final String txid;
  @override
  final int amountSats;
  @override
  final int createdAt;

  @override
  String toString() {
    return 'Transaction.commitment(txid: $txid, amountSats: $amountSats, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Transaction_CommitmentImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.amountSats, amountSats) ||
                other.amountSats == amountSats) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txid, amountSats, createdAt);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Transaction_CommitmentImplCopyWith<_$Transaction_CommitmentImpl>
      get copyWith => __$$Transaction_CommitmentImplCopyWithImpl<
          _$Transaction_CommitmentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String txid, BigInt amountSats, int? confirmedAt)
        boarding,
    required TResult Function(String txid, int amountSats, int createdAt)
        commitment,
    required TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)
        redeem,
    required TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)
        ark,
  }) {
    return commitment(txid, amountSats, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult? Function(String txid, int amountSats, int createdAt)? commitment,
    TResult? Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult? Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
  }) {
    return commitment?.call(txid, amountSats, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult Function(String txid, int amountSats, int createdAt)? commitment,
    TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
    required TResult orElse(),
  }) {
    if (commitment != null) {
      return commitment(txid, amountSats, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Transaction_Boarding value) boarding,
    required TResult Function(Transaction_Commitment value) commitment,
    required TResult Function(Transaction_Redeem value) redeem,
    required TResult Function(Transaction_Ark value) ark,
  }) {
    return commitment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Transaction_Boarding value)? boarding,
    TResult? Function(Transaction_Commitment value)? commitment,
    TResult? Function(Transaction_Redeem value)? redeem,
    TResult? Function(Transaction_Ark value)? ark,
  }) {
    return commitment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Transaction_Boarding value)? boarding,
    TResult Function(Transaction_Commitment value)? commitment,
    TResult Function(Transaction_Redeem value)? redeem,
    TResult Function(Transaction_Ark value)? ark,
    required TResult orElse(),
  }) {
    if (commitment != null) {
      return commitment(this);
    }
    return orElse();
  }
}

abstract class Transaction_Commitment extends Transaction {
  const factory Transaction_Commitment(
      {required final String txid,
      required final int amountSats,
      required final int createdAt}) = _$Transaction_CommitmentImpl;
  const Transaction_Commitment._() : super._();

  @override
  String get txid;
  @override
  int get amountSats;
  int get createdAt;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Transaction_CommitmentImplCopyWith<_$Transaction_CommitmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Transaction_RedeemImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$Transaction_RedeemImplCopyWith(_$Transaction_RedeemImpl value,
          $Res Function(_$Transaction_RedeemImpl) then) =
      __$$Transaction_RedeemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, BigInt amountSats, bool isSettled, int? createdAt});
}

/// @nodoc
class __$$Transaction_RedeemImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$Transaction_RedeemImpl>
    implements _$$Transaction_RedeemImplCopyWith<$Res> {
  __$$Transaction_RedeemImplCopyWithImpl(_$Transaction_RedeemImpl _value,
      $Res Function(_$Transaction_RedeemImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? amountSats = null,
    Object? isSettled = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$Transaction_RedeemImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      amountSats: null == amountSats
          ? _value.amountSats
          : amountSats // ignore: cast_nullable_to_non_nullable
              as BigInt,
      isSettled: null == isSettled
          ? _value.isSettled
          : isSettled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$Transaction_RedeemImpl extends Transaction_Redeem {
  const _$Transaction_RedeemImpl(
      {required this.txid,
      required this.amountSats,
      required this.isSettled,
      this.createdAt})
      : super._();

  @override
  final String txid;
  @override
  final BigInt amountSats;
  @override
  final bool isSettled;
  @override
  final int? createdAt;

  @override
  String toString() {
    return 'Transaction.redeem(txid: $txid, amountSats: $amountSats, isSettled: $isSettled, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Transaction_RedeemImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.amountSats, amountSats) ||
                other.amountSats == amountSats) &&
            (identical(other.isSettled, isSettled) ||
                other.isSettled == isSettled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, txid, amountSats, isSettled, createdAt);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Transaction_RedeemImplCopyWith<_$Transaction_RedeemImpl> get copyWith =>
      __$$Transaction_RedeemImplCopyWithImpl<_$Transaction_RedeemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String txid, BigInt amountSats, int? confirmedAt)
        boarding,
    required TResult Function(String txid, int amountSats, int createdAt)
        commitment,
    required TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)
        redeem,
    required TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)
        ark,
  }) {
    return redeem(txid, amountSats, isSettled, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult? Function(String txid, int amountSats, int createdAt)? commitment,
    TResult? Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult? Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
  }) {
    return redeem?.call(txid, amountSats, isSettled, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult Function(String txid, int amountSats, int createdAt)? commitment,
    TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
    required TResult orElse(),
  }) {
    if (redeem != null) {
      return redeem(txid, amountSats, isSettled, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Transaction_Boarding value) boarding,
    required TResult Function(Transaction_Commitment value) commitment,
    required TResult Function(Transaction_Redeem value) redeem,
    required TResult Function(Transaction_Ark value) ark,
  }) {
    return redeem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Transaction_Boarding value)? boarding,
    TResult? Function(Transaction_Commitment value)? commitment,
    TResult? Function(Transaction_Redeem value)? redeem,
    TResult? Function(Transaction_Ark value)? ark,
  }) {
    return redeem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Transaction_Boarding value)? boarding,
    TResult Function(Transaction_Commitment value)? commitment,
    TResult Function(Transaction_Redeem value)? redeem,
    TResult Function(Transaction_Ark value)? ark,
    required TResult orElse(),
  }) {
    if (redeem != null) {
      return redeem(this);
    }
    return orElse();
  }
}

abstract class Transaction_Redeem extends Transaction {
  const factory Transaction_Redeem(
      {required final String txid,
      required final BigInt amountSats,
      required final bool isSettled,
      final int? createdAt}) = _$Transaction_RedeemImpl;
  const Transaction_Redeem._() : super._();

  @override
  String get txid;
  @override
  BigInt get amountSats;
  bool get isSettled;
  int? get createdAt;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Transaction_RedeemImplCopyWith<_$Transaction_RedeemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Transaction_ArkImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$Transaction_ArkImplCopyWith(_$Transaction_ArkImpl value,
          $Res Function(_$Transaction_ArkImpl) then) =
      __$$Transaction_ArkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, int amountSats, bool isSettled, int createdAt});
}

/// @nodoc
class __$$Transaction_ArkImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$Transaction_ArkImpl>
    implements _$$Transaction_ArkImplCopyWith<$Res> {
  __$$Transaction_ArkImplCopyWithImpl(
      _$Transaction_ArkImpl _value, $Res Function(_$Transaction_ArkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? amountSats = null,
    Object? isSettled = null,
    Object? createdAt = null,
  }) {
    return _then(_$Transaction_ArkImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      amountSats: null == amountSats
          ? _value.amountSats
          : amountSats // ignore: cast_nullable_to_non_nullable
              as int,
      isSettled: null == isSettled
          ? _value.isSettled
          : isSettled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Transaction_ArkImpl extends Transaction_Ark {
  const _$Transaction_ArkImpl(
      {required this.txid,
      required this.amountSats,
      required this.isSettled,
      required this.createdAt})
      : super._();

  @override
  final String txid;
  @override
  final int amountSats;
  @override
  final bool isSettled;
  @override
  final int createdAt;

  @override
  String toString() {
    return 'Transaction.ark(txid: $txid, amountSats: $amountSats, isSettled: $isSettled, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Transaction_ArkImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.amountSats, amountSats) ||
                other.amountSats == amountSats) &&
            (identical(other.isSettled, isSettled) ||
                other.isSettled == isSettled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, txid, amountSats, isSettled, createdAt);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Transaction_ArkImplCopyWith<_$Transaction_ArkImpl> get copyWith =>
      __$$Transaction_ArkImplCopyWithImpl<_$Transaction_ArkImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String txid, BigInt amountSats, int? confirmedAt)
        boarding,
    required TResult Function(String txid, int amountSats, int createdAt)
        commitment,
    required TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)
        redeem,
    required TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)
        ark,
  }) {
    return ark(txid, amountSats, isSettled, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult? Function(String txid, int amountSats, int createdAt)? commitment,
    TResult? Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult? Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
  }) {
    return ark?.call(txid, amountSats, isSettled, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String txid, BigInt amountSats, int? confirmedAt)?
        boarding,
    TResult Function(String txid, int amountSats, int createdAt)? commitment,
    TResult Function(
            String txid, BigInt amountSats, bool isSettled, int? createdAt)?
        redeem,
    TResult Function(
            String txid, int amountSats, bool isSettled, int createdAt)?
        ark,
    required TResult orElse(),
  }) {
    if (ark != null) {
      return ark(txid, amountSats, isSettled, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Transaction_Boarding value) boarding,
    required TResult Function(Transaction_Commitment value) commitment,
    required TResult Function(Transaction_Redeem value) redeem,
    required TResult Function(Transaction_Ark value) ark,
  }) {
    return ark(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Transaction_Boarding value)? boarding,
    TResult? Function(Transaction_Commitment value)? commitment,
    TResult? Function(Transaction_Redeem value)? redeem,
    TResult? Function(Transaction_Ark value)? ark,
  }) {
    return ark?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Transaction_Boarding value)? boarding,
    TResult Function(Transaction_Commitment value)? commitment,
    TResult Function(Transaction_Redeem value)? redeem,
    TResult Function(Transaction_Ark value)? ark,
    required TResult orElse(),
  }) {
    if (ark != null) {
      return ark(this);
    }
    return orElse();
  }
}

abstract class Transaction_Ark extends Transaction {
  const factory Transaction_Ark(
      {required final String txid,
      required final int amountSats,
      required final bool isSettled,
      required final int createdAt}) = _$Transaction_ArkImpl;
  const Transaction_Ark._() : super._();

  @override
  String get txid;
  @override
  int get amountSats;
  bool get isSettled;
  int get createdAt;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Transaction_ArkImplCopyWith<_$Transaction_ArkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
