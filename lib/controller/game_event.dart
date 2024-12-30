import 'package:bonfire/bonfire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/enums/enemy_type.dart';
import '../unit/base/enemy_id.dart';
import '../unit/base/goblin.dart';
import '../unit/tower/tower_component.dart';

part 'game_event.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
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
  //

  const factory GameEvent.enemyGetDamaged(EnemyId id) =
      EnemyGetDamagedGameEvent;
  const factory GameEvent.enemySpawn() = EnemySpawnGameEvent;
  const factory GameEvent.spawnOne(EnemyType type) = SpawnOneGameEvent;
  const factory GameEvent.enemyGo(Goblin enemy) = EnemyGoGameEvent;
  const factory GameEvent.createStage() = CreateStageGameEvent;
  const factory GameEvent.startDragButton(Vector2 position) =
      StartDragButtonGameEvent;
  const factory GameEvent.moveDragButton(Vector2 position) =
      MoveDragButtonGameEvent;
  const factory GameEvent.finishDragButton(Vector2 position) =
      FinishDragButtonGameEvent;
}
