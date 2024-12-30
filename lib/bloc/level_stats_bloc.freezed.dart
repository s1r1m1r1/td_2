// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_stats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LevelStatsEvent {}

/// @nodoc

class _$$ResetEventImpl extends _$ResetEvent {
  const _$$ResetEventImpl() : super._();

  @override
  String toString() {
    return 'LevelStatsEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$$ResetEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$ResetEvent extends LevelStatsEvent {
  const factory _$ResetEvent() = _$$ResetEventImpl;
  const _$ResetEvent._() : super._();
}

/// @nodoc

class _$$IncrementEnemyKilledEventImpl extends _$IncrementEnemyKilledEvent {
  const _$$IncrementEnemyKilledEventImpl() : super._();

  @override
  String toString() {
    return 'LevelStatsEvent.incrementEnemyKilled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$IncrementEnemyKilledEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$IncrementEnemyKilledEvent extends LevelStatsEvent {
  const factory _$IncrementEnemyKilledEvent() =
      _$$IncrementEnemyKilledEventImpl;
  const _$IncrementEnemyKilledEvent._() : super._();
}

/// @nodoc

class _$$IncrementEnemyMissedEventImpl extends _$IncrementEnemyMissedEvent {
  const _$$IncrementEnemyMissedEventImpl() : super._();

  @override
  String toString() {
    return 'LevelStatsEvent.incrementEnemyMissed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$IncrementEnemyMissedEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$IncrementEnemyMissedEvent extends LevelStatsEvent {
  const factory _$IncrementEnemyMissedEvent() =
      _$$IncrementEnemyMissedEventImpl;
  const _$IncrementEnemyMissedEvent._() : super._();
}

/// @nodoc

class _$$IncrementWaveEventImpl extends _$IncrementWaveEvent {
  const _$$IncrementWaveEventImpl() : super._();

  @override
  String toString() {
    return 'LevelStatsEvent.incrementWave()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$IncrementWaveEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _$IncrementWaveEvent extends LevelStatsEvent {
  const factory _$IncrementWaveEvent() = _$$IncrementWaveEventImpl;
  const _$IncrementWaveEvent._() : super._();
}

/// @nodoc
mixin _$LevelStatsState {
  int get wave => throw _privateConstructorUsedError;
  int get enemyKilled => throw _privateConstructorUsedError;
  int get enemyMissed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LevelStatsStateCopyWith<LevelStatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelStatsStateCopyWith<$Res> {
  factory $LevelStatsStateCopyWith(
          LevelStatsState value, $Res Function(LevelStatsState) then) =
      _$LevelStatsStateCopyWithImpl<$Res, LevelStatsState>;
  @useResult
  $Res call({int wave, int enemyKilled, int enemyMissed});
}

/// @nodoc
class _$LevelStatsStateCopyWithImpl<$Res, $Val extends LevelStatsState>
    implements $LevelStatsStateCopyWith<$Res> {
  _$LevelStatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wave = null,
    Object? enemyKilled = null,
    Object? enemyMissed = null,
  }) {
    return _then(_value.copyWith(
      wave: null == wave
          ? _value.wave
          : wave // ignore: cast_nullable_to_non_nullable
              as int,
      enemyKilled: null == enemyKilled
          ? _value.enemyKilled
          : enemyKilled // ignore: cast_nullable_to_non_nullable
              as int,
      enemyMissed: null == enemyMissed
          ? _value.enemyMissed
          : enemyMissed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$LevelStatsStateImplCopyWith<$Res>
    implements $LevelStatsStateCopyWith<$Res> {
  factory _$$$LevelStatsStateImplCopyWith(_$$LevelStatsStateImpl value,
          $Res Function(_$$LevelStatsStateImpl) then) =
      __$$$LevelStatsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int wave, int enemyKilled, int enemyMissed});
}

/// @nodoc
class __$$$LevelStatsStateImplCopyWithImpl<$Res>
    extends _$LevelStatsStateCopyWithImpl<$Res, _$$LevelStatsStateImpl>
    implements _$$$LevelStatsStateImplCopyWith<$Res> {
  __$$$LevelStatsStateImplCopyWithImpl(_$$LevelStatsStateImpl _value,
      $Res Function(_$$LevelStatsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wave = null,
    Object? enemyKilled = null,
    Object? enemyMissed = null,
  }) {
    return _then(_$$LevelStatsStateImpl(
      wave: null == wave
          ? _value.wave
          : wave // ignore: cast_nullable_to_non_nullable
              as int,
      enemyKilled: null == enemyKilled
          ? _value.enemyKilled
          : enemyKilled // ignore: cast_nullable_to_non_nullable
              as int,
      enemyMissed: null == enemyMissed
          ? _value.enemyMissed
          : enemyMissed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$$LevelStatsStateImpl extends $LevelStatsState {
  const _$$LevelStatsStateImpl(
      {required this.wave,
      required this.enemyKilled,
      required this.enemyMissed})
      : super._();

  @override
  final int wave;
  @override
  final int enemyKilled;
  @override
  final int enemyMissed;

  @override
  String toString() {
    return 'LevelStatsState(wave: $wave, enemyKilled: $enemyKilled, enemyMissed: $enemyMissed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$LevelStatsStateImpl &&
            (identical(other.wave, wave) || other.wave == wave) &&
            (identical(other.enemyKilled, enemyKilled) ||
                other.enemyKilled == enemyKilled) &&
            (identical(other.enemyMissed, enemyMissed) ||
                other.enemyMissed == enemyMissed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wave, enemyKilled, enemyMissed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$LevelStatsStateImplCopyWith<_$$LevelStatsStateImpl> get copyWith =>
      __$$$LevelStatsStateImplCopyWithImpl<_$$LevelStatsStateImpl>(
          this, _$identity);
}

abstract class $LevelStatsState extends LevelStatsState {
  const factory $LevelStatsState(
      {required final int wave,
      required final int enemyKilled,
      required final int enemyMissed}) = _$$LevelStatsStateImpl;
  const $LevelStatsState._() : super._();

  @override
  int get wave;
  @override
  int get enemyKilled;
  @override
  int get enemyMissed;
  @override
  @JsonKey(ignore: true)
  _$$$LevelStatsStateImplCopyWith<_$$LevelStatsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
