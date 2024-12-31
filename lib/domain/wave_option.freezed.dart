// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wave_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WaveOption {
  int get id => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  EnemyType get enemyType => throw _privateConstructorUsedError;
  Duration get unitInterval => throw _privateConstructorUsedError;
  Duration get nextWave => throw _privateConstructorUsedError;
}

/// @nodoc

class _$$WaveOptionImpl extends $WaveOption {
  const _$$WaveOptionImpl(
      {required this.id,
      required this.count,
      required this.enemyType,
      required this.unitInterval,
      required this.nextWave})
      : super._();

  @override
  final int id;
  @override
  final int count;
  @override
  final EnemyType enemyType;
  @override
  final Duration unitInterval;
  @override
  final Duration nextWave;

  @override
  String toString() {
    return 'WaveOption(id: $id, count: $count, enemyType: $enemyType, unitInterval: $unitInterval, nextWave: $nextWave)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$WaveOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.enemyType, enemyType) ||
                other.enemyType == enemyType) &&
            (identical(other.unitInterval, unitInterval) ||
                other.unitInterval == unitInterval) &&
            (identical(other.nextWave, nextWave) ||
                other.nextWave == nextWave));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, count, enemyType, unitInterval, nextWave);
}

abstract class $WaveOption extends WaveOption {
  const factory $WaveOption(
      {required final int id,
      required final int count,
      required final EnemyType enemyType,
      required final Duration unitInterval,
      required final Duration nextWave}) = _$$WaveOptionImpl;
  const $WaveOption._() : super._();

  @override
  int get id;
  @override
  int get count;
  @override
  EnemyType get enemyType;
  @override
  Duration get unitInterval;
  @override
  Duration get nextWave;
}
