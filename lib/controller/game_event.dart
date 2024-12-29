import 'package:bonfire/bonfire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../unit/tower/tower_component.dart';

part 'game_event.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class GameEvent with _$GameEvent {
  const GameEvent._();
  const factory GameEvent.started() = StartedGameEvent;
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
  const factory GameEvent.enemySpawn() = EnemySpawnGameEvent;
  const factory GameEvent.enemyMissed() = EnemyMissedGameEvent;
  const factory GameEvent.enemyKilled({required int mineValue}) =
      EnemyKilledGameEvent;
  const factory GameEvent.enemyNextWave() = EnemyNextWaveGameEvent;
  const factory GameEvent.setDraggable(Vector2 position) = SetDraggableGameEvent;
}
