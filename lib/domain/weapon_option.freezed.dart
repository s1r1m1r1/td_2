// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weapon_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeaponOption {
  WeaponId get id => throw _privateConstructorUsedError; // 1.0 like tileSize
  double get radarDistance => throw _privateConstructorUsedError;
  double get bulletSpeed => throw _privateConstructorUsedError;
  double get bulletDistance => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  ImageProvider<Object> get barImage => throw _privateConstructorUsedError;
}

/// @nodoc

class _$$CannonWeaponOptionImpl extends $CannonWeaponOption {
  const _$$CannonWeaponOptionImpl(
      {required this.id,
      required this.radarDistance,
      required this.bulletSpeed,
      required this.bulletDistance,
      required this.price,
      required this.barImage})
      : super._();

  @override
  final WeaponId id;
// 1.0 like tileSize
  @override
  final double radarDistance;
  @override
  final double bulletSpeed;
  @override
  final double bulletDistance;
  @override
  final double price;
  @override
  final ImageProvider<Object> barImage;

  @override
  String toString() {
    return 'WeaponOption.cannon(id: $id, radarDistance: $radarDistance, bulletSpeed: $bulletSpeed, bulletDistance: $bulletDistance, price: $price, barImage: $barImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$CannonWeaponOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.radarDistance, radarDistance) ||
                other.radarDistance == radarDistance) &&
            (identical(other.bulletSpeed, bulletSpeed) ||
                other.bulletSpeed == bulletSpeed) &&
            (identical(other.bulletDistance, bulletDistance) ||
                other.bulletDistance == bulletDistance) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.barImage, barImage) ||
                other.barImage == barImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, radarDistance, bulletSpeed,
      bulletDistance, price, barImage);
}

abstract class $CannonWeaponOption extends WeaponOption
    implements IWeaponOption {
  const factory $CannonWeaponOption(
          {required final WeaponId id,
          required final double radarDistance,
          required final double bulletSpeed,
          required final double bulletDistance,
          required final double price,
          required final ImageProvider<Object> barImage}) =
      _$$CannonWeaponOptionImpl;
  const $CannonWeaponOption._() : super._();

  @override
  WeaponId get id;
  @override // 1.0 like tileSize
  double get radarDistance;
  @override
  double get bulletSpeed;
  @override
  double get bulletDistance;
  @override
  double get price;
  @override
  ImageProvider<Object> get barImage;
}

/// @nodoc

class _$$MissileWeaponOptionImpl extends $MissileWeaponOption {
  const _$$MissileWeaponOptionImpl(
      {required this.id,
      required this.radarDistance,
      required this.bulletSpeed,
      required this.bulletDistance,
      required this.price,
      required this.barImage})
      : super._();

  @override
  final WeaponId id;
// 1.0 like tileSize
  @override
  final double radarDistance;
  @override
  final double bulletSpeed;
  @override
  final double bulletDistance;
  @override
  final double price;
  @override
  final ImageProvider<Object> barImage;

  @override
  String toString() {
    return 'WeaponOption.missile(id: $id, radarDistance: $radarDistance, bulletSpeed: $bulletSpeed, bulletDistance: $bulletDistance, price: $price, barImage: $barImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$MissileWeaponOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.radarDistance, radarDistance) ||
                other.radarDistance == radarDistance) &&
            (identical(other.bulletSpeed, bulletSpeed) ||
                other.bulletSpeed == bulletSpeed) &&
            (identical(other.bulletDistance, bulletDistance) ||
                other.bulletDistance == bulletDistance) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.barImage, barImage) ||
                other.barImage == barImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, radarDistance, bulletSpeed,
      bulletDistance, price, barImage);
}

abstract class $MissileWeaponOption extends WeaponOption
    implements IWeaponOption {
  const factory $MissileWeaponOption(
          {required final WeaponId id,
          required final double radarDistance,
          required final double bulletSpeed,
          required final double bulletDistance,
          required final double price,
          required final ImageProvider<Object> barImage}) =
      _$$MissileWeaponOptionImpl;
  const $MissileWeaponOption._() : super._();

  @override
  WeaponId get id;
  @override // 1.0 like tileSize
  double get radarDistance;
  @override
  double get bulletSpeed;
  @override
  double get bulletDistance;
  @override
  double get price;
  @override
  ImageProvider<Object> get barImage;
}

/// @nodoc
mixin _$WeaponId {
  int get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$WeaponIdImpl extends _WeaponId {
  const _$WeaponIdImpl(this.value) : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'WeaponId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeaponIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _WeaponId extends WeaponId {
  const factory _WeaponId(final int value) = _$WeaponIdImpl;
  const _WeaponId._() : super._();

  @override
  int get value;
}
