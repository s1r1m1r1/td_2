import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:td_2/domain/enums/enemy_type.dart';
part 'wave_option.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class WaveOption with _$WaveOption {
  const WaveOption._();
  const factory WaveOption({
    required int id,
    required int count,
    required EnemyType enemyType,
    required Duration unitInterval,
    required Duration nextWave,
  }) = $WaveOption;
}
