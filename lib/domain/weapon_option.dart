import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'weapon_option.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class WeaponOption with _$WeaponOption {
  const WeaponOption._();
  @Implements<IWeaponOption>()
  const factory WeaponOption.cannon({
    required WeaponId id,
    // 1.0 like tileSize
    required double radarDistance,
    required double bulletSpeed,
    required double bulletDistance,
    required double price,
    required ImageProvider barImage,
  }) = $CannonWeaponOption;

  @Implements<IWeaponOption>()
  const factory WeaponOption.missile({
    required WeaponId id,
    // 1.0 like tileSize
    required double radarDistance,
    required double bulletSpeed,
    required double bulletDistance,
    required double price,
    required ImageProvider barImage,
  }) = $MissileWeaponOption;
}

sealed class IWeaponOption implements WeaponOption {
  @override
  WeaponId get id;

  @override
  double get price;

  @override
  ImageProvider get barImage;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class WeaponId with _$WeaponId {
  const WeaponId._();
  const factory WeaponId(int value) = _WeaponId;
}
