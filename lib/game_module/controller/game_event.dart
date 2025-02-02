import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/enums/enemy_type.dart';
import '../../domain/weapon_option.dart';
import '../unit/enemy/enemy.dart';
import '../unit/enemy/enemy_id.dart';
import '../unit/tower/towers.dart';

part 'game_event.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  copyWith: false,
  equal: false,
)
sealed class GameEvent with _$GameEvent {
  const GameEvent._();
  const factory GameEvent.paused() = PausedGameEvent;
  const factory GameEvent.resumed() = ResumedGameEvent;
  const factory GameEvent.weaponBuilding({required RotationTower component}) =
      WeaponBuildingGameEvent;
  const factory GameEvent.weaponSelected() = WeaponSelectedGameEvent;
  const factory GameEvent.weaponUnSelected() = WeaponUnSelectedGameEvent;
  const factory GameEvent.weaponBuildDone({required RotationTower weapon}) =
      WeaponBuildDoneGameEvent;
  const factory GameEvent.weaponDestroyed() = WeaponDestroyedGameEvent;
  const factory GameEvent.weaponBlocked() = WeaponBlockedGameEvent;
  const factory GameEvent.weaponShowAction({required RotationTower weapon}) =
      WeaponShowActionGameEvent;
  const factory GameEvent.weaponShowProfile() = WeaponShowProfileGameEvent;
  const factory GameEvent.enemyMissed() = EnemyMissedGameEvent;
  const factory GameEvent.enemyKilled({required int mineValue}) =
      EnemyKilledGameEvent;
  const factory GameEvent.enemyNextWave() = EnemyNextWaveGameEvent;
  const factory GameEvent.lab(dynamic value) = LabGameEvent;
  //

  const factory GameEvent.enemyGetDamaged(EnemyId id) =
      EnemyGetDamagedGameEvent;
  const factory GameEvent.enemySpawn() = EnemySpawnGameEvent;
  const factory GameEvent.spawnOne(EnemyType type) = SpawnOneGameEvent;
  const factory GameEvent.nextWave(int index) = NextWaveGameEvent;
  const factory GameEvent.enemyGo(Enemy enemy) = EnemyGoGameEvent;
  const factory GameEvent.createStage() = CreateStageGameEvent;
  const factory GameEvent.movePointerGlobal(Vector2 position) =
      MovePointerGlobalGameEvent;
  const factory GameEvent.finishPointerGlobal(Vector2 position, WeaponId id) =
      FinishPointerGlobalGameEvent;

  const factory GameEvent.onTapDown(Vector2 position) = OnTapDownGE;
  const factory GameEvent.onTapUp(Vector2 position) = OnTapUpGE;
  const factory GameEvent.onDragUpdate(Vector2 position) = OnDragUpdateGE;
}
