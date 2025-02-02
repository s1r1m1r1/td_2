import 'package:freezed_annotation/freezed_annotation.dart';
part 'enemy_id.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class EnemyId with _$EnemyId {
  const EnemyId._();
  const factory EnemyId(int id) = _EnemyId;

// ----- generating new id ---------------
  static int _last = 0;
  factory EnemyId.newId() {
    _last += 1;
    return EnemyId(_last);
  }
}
