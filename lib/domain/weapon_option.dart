import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'weapon_option.freezed.dart';

extension type WeaponId(int id) {}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class WeaponOption with _$WeaponOption {
  const WeaponOption._();
  @Implements<IWeaponOption>()
  const factory WeaponOption.rocket({
    required WeaponId id,
    // 1.0 like tileSize
    required double radarDistance,
    required double bulletSpeed,
    required double bulletDistance,
    required double price,
    required ImageProvider barImage,
  }) = $RocketWeaponOption;

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
