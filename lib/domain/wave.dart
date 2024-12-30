import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:td_2/domain/enums/enemy_type.dart';
part 'wave.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class Wave with _$Wave {
  const Wave._();
  const factory Wave({
    required int id,
    required int count,
    required EnemyType enemyType,
    required Duration unitInterval,
    required Duration nextWave,
  }) = $Wave;
}
