import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/tile_type.dart';
part 'map_option.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class LayerOption with _$LayerOption {
  const LayerOption._();
  const factory LayerOption({
    required int width,
    required int height,
    required List<TileOption> tiles,
  }) = _LayerOption;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class TileOption with _$TileOption {
  const TileOption._();
  const factory TileOption({
    required int x,
    required int y,
    required String assetPath,
    required TileType type,
  }) = _TileOption;
}
