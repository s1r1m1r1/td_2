import 'package:freezed_annotation/freezed_annotation.dart';

import 'map_option.dart';
import 'wave_option.dart';
part 'stage_option.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class StageOption with _$StageOption {
  const StageOption._();
  const factory StageOption({
    required int id,
    required List<WaveOption> waves,
    required LayerOption layer,
  }) = _StageOption;
}
