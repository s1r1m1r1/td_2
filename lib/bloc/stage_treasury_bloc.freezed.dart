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
mixin _$StageTreasuryEvent {}

/// @nodoc

class _$$AddGoldEventImpl extends _$AddGoldEvent {
  const _$$AddGoldEventImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'StageTreasuryEvent.addGold(value: $value)';
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

abstract class _$AddGoldEvent extends StageTreasuryEvent {
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
    return 'StageTreasuryEvent.subtractGold(value: $value)';
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

abstract class _$SubtractGoldEvent extends StageTreasuryEvent {
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
    return 'StageTreasuryEvent.addMinerals(value: $value)';
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

abstract class _$AddMineralsEvent extends StageTreasuryEvent {
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
    return 'StageTreasuryEvent.subtractMinerals(value: $value)';
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

abstract class _$SubtractMineralsEvent extends StageTreasuryEvent {
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
    return 'StageTreasuryEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$$ResetEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$ResetEvent extends StageTreasuryEvent {
  const factory _$ResetEvent() = _$$ResetEventImpl;
  const _$ResetEvent._() : super._();
}

/// @nodoc
mixin _$StageTreasuryState {
  int get gold => throw _privateConstructorUsedError;
  int get minerals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StageTreasuryStateCopyWith<StageTreasuryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageTreasuryStateCopyWith<$Res> {
  factory $StageTreasuryStateCopyWith(
          StageTreasuryState value, $Res Function(StageTreasuryState) then) =
      _$StageTreasuryStateCopyWithImpl<$Res, StageTreasuryState>;
  @useResult
  $Res call({int gold, int minerals});
}

/// @nodoc
class _$StageTreasuryStateCopyWithImpl<$Res, $Val extends StageTreasuryState>
    implements $StageTreasuryStateCopyWith<$Res> {
  _$StageTreasuryStateCopyWithImpl(this._value, this._then);

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
abstract class _$$$StageTreasuryStateImplCopyWith<$Res>
    implements $StageTreasuryStateCopyWith<$Res> {
  factory _$$$StageTreasuryStateImplCopyWith(_$$StageTreasuryStateImpl value,
          $Res Function(_$$StageTreasuryStateImpl) then) =
      __$$$StageTreasuryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gold, int minerals});
}

/// @nodoc
class __$$$StageTreasuryStateImplCopyWithImpl<$Res>
    extends _$StageTreasuryStateCopyWithImpl<$Res, _$$StageTreasuryStateImpl>
    implements _$$$StageTreasuryStateImplCopyWith<$Res> {
  __$$$StageTreasuryStateImplCopyWithImpl(_$$StageTreasuryStateImpl _value,
      $Res Function(_$$StageTreasuryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gold = null,
    Object? minerals = null,
  }) {
    return _then(_$$StageTreasuryStateImpl(
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

class _$$StageTreasuryStateImpl extends $StageTreasuryState {
  const _$$StageTreasuryStateImpl({required this.gold, required this.minerals})
      : super._();

  @override
  final int gold;
  @override
  final int minerals;

  @override
  String toString() {
    return 'StageTreasuryState(gold: $gold, minerals: $minerals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$StageTreasuryStateImpl &&
            (identical(other.gold, gold) || other.gold == gold) &&
            (identical(other.minerals, minerals) ||
                other.minerals == minerals));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gold, minerals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$StageTreasuryStateImplCopyWith<_$$StageTreasuryStateImpl> get copyWith =>
      __$$$StageTreasuryStateImplCopyWithImpl<_$$StageTreasuryStateImpl>(
          this, _$identity);
}

abstract class $StageTreasuryState extends StageTreasuryState {
  const factory $StageTreasuryState(
      {required final int gold,
      required final int minerals}) = _$$StageTreasuryStateImpl;
  const $StageTreasuryState._() : super._();

  @override
  int get gold;
  @override
  int get minerals;
  @override
  @JsonKey(ignore: true)
  _$$$StageTreasuryStateImplCopyWith<_$$StageTreasuryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
