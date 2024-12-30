// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_treasury_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LevelTreasuryEvent {}

/// @nodoc

class _$$AddGoldEventImpl extends _$AddGoldEvent {
  const _$$AddGoldEventImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'LevelTreasuryEvent.addGold(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$AddGoldEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _$AddGoldEvent extends LevelTreasuryEvent {
  const factory _$AddGoldEvent(final int value) = _$$AddGoldEventImpl;
  const _$AddGoldEvent._() : super._();

  int get value;
}

/// @nodoc

class _$$SubtractGoldEventImpl extends _$SubtractGoldEvent {
  const _$$SubtractGoldEventImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'LevelTreasuryEvent.subtractGold(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$SubtractGoldEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _$SubtractGoldEvent extends LevelTreasuryEvent {
  const factory _$SubtractGoldEvent(final int value) = _$$SubtractGoldEventImpl;
  const _$SubtractGoldEvent._() : super._();

  int get value;
}

/// @nodoc

class _$$AddMineralsEventImpl extends _$AddMineralsEvent {
  const _$$AddMineralsEventImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'LevelTreasuryEvent.addMinerals(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$AddMineralsEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _$AddMineralsEvent extends LevelTreasuryEvent {
  const factory _$AddMineralsEvent(final int value) = _$$AddMineralsEventImpl;
  const _$AddMineralsEvent._() : super._();

  int get value;
}

/// @nodoc

class _$$SubtractMineralsEventImpl extends _$SubtractMineralsEvent {
  const _$$SubtractMineralsEventImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'LevelTreasuryEvent.subtractMinerals(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$SubtractMineralsEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _$SubtractMineralsEvent extends LevelTreasuryEvent {
  const factory _$SubtractMineralsEvent(final int value) =
      _$$SubtractMineralsEventImpl;
  const _$SubtractMineralsEvent._() : super._();

  int get value;
}

/// @nodoc

class _$$ResetEventImpl extends _$ResetEvent {
  const _$$ResetEventImpl() : super._();

  @override
  String toString() {
    return 'LevelTreasuryEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$$ResetEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$ResetEvent extends LevelTreasuryEvent {
  const factory _$ResetEvent() = _$$ResetEventImpl;
  const _$ResetEvent._() : super._();
}

/// @nodoc
mixin _$LevelTreasuryState {
  int get gold => throw _privateConstructorUsedError;
  int get minerals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LevelTreasuryStateCopyWith<LevelTreasuryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelTreasuryStateCopyWith<$Res> {
  factory $LevelTreasuryStateCopyWith(
          LevelTreasuryState value, $Res Function(LevelTreasuryState) then) =
      _$LevelTreasuryStateCopyWithImpl<$Res, LevelTreasuryState>;
  @useResult
  $Res call({int gold, int minerals});
}

/// @nodoc
class _$LevelTreasuryStateCopyWithImpl<$Res, $Val extends LevelTreasuryState>
    implements $LevelTreasuryStateCopyWith<$Res> {
  _$LevelTreasuryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gold = null,
    Object? minerals = null,
  }) {
    return _then(_value.copyWith(
      gold: null == gold
          ? _value.gold
          : gold // ignore: cast_nullable_to_non_nullable
              as int,
      minerals: null == minerals
          ? _value.minerals
          : minerals // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$LevelTreasuryStateImplCopyWith<$Res>
    implements $LevelTreasuryStateCopyWith<$Res> {
  factory _$$$LevelTreasuryStateImplCopyWith(_$$LevelTreasuryStateImpl value,
          $Res Function(_$$LevelTreasuryStateImpl) then) =
      __$$$LevelTreasuryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gold, int minerals});
}

/// @nodoc
class __$$$LevelTreasuryStateImplCopyWithImpl<$Res>
    extends _$LevelTreasuryStateCopyWithImpl<$Res, _$$LevelTreasuryStateImpl>
    implements _$$$LevelTreasuryStateImplCopyWith<$Res> {
  __$$$LevelTreasuryStateImplCopyWithImpl(_$$LevelTreasuryStateImpl _value,
      $Res Function(_$$LevelTreasuryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gold = null,
    Object? minerals = null,
  }) {
    return _then(_$$LevelTreasuryStateImpl(
      gold: null == gold
          ? _value.gold
          : gold // ignore: cast_nullable_to_non_nullable
              as int,
      minerals: null == minerals
          ? _value.minerals
          : minerals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$$LevelTreasuryStateImpl extends $LevelTreasuryState {
  const _$$LevelTreasuryStateImpl({required this.gold, required this.minerals})
      : super._();

  @override
  final int gold;
  @override
  final int minerals;

  @override
  String toString() {
    return 'LevelTreasuryState(gold: $gold, minerals: $minerals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$LevelTreasuryStateImpl &&
            (identical(other.gold, gold) || other.gold == gold) &&
            (identical(other.minerals, minerals) ||
                other.minerals == minerals));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gold, minerals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$LevelTreasuryStateImplCopyWith<_$$LevelTreasuryStateImpl> get copyWith =>
      __$$$LevelTreasuryStateImplCopyWithImpl<_$$LevelTreasuryStateImpl>(
          this, _$identity);
}

abstract class $LevelTreasuryState extends LevelTreasuryState {
  const factory $LevelTreasuryState(
      {required final int gold,
      required final int minerals}) = _$$LevelTreasuryStateImpl;
  const $LevelTreasuryState._() : super._();

  @override
  int get gold;
  @override
  int get minerals;
  @override
  @JsonKey(ignore: true)
  _$$$LevelTreasuryStateImplCopyWith<_$$LevelTreasuryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
