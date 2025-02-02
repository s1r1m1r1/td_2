import 'package:freezed_annotation/freezed_annotation.dart';
part 'mixin_radar_config.freezed.dart';

enum RadarMode { findBest, findFirst, disable }

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
class MixinRadarConfig with _$MixinRadarConfig {
  const MixinRadarConfig._();
  const factory MixinRadarConfig({
    @Default(RadarMode.findBest) RadarMode radarMode,
    @Default(true) bool radarOn,
    required double distScan,
  }) = _MixinRadarConfig;
}
