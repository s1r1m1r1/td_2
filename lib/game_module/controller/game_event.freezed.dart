// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameEvent {}

/// @nodoc

class _$PausedGameEventImpl extends PausedGameEvent {
  const _$PausedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.paused()';
  }
}

abstract class PausedGameEvent extends GameEvent {
  const factory PausedGameEvent() = _$PausedGameEventImpl;
  const PausedGameEvent._() : super._();
}

/// @nodoc

class _$ResumedGameEventImpl extends ResumedGameEvent {
  const _$ResumedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.resumed()';
  }
}

abstract class ResumedGameEvent extends GameEvent {
  const factory ResumedGameEvent() = _$ResumedGameEventImpl;
  const ResumedGameEvent._() : super._();
}

/// @nodoc

class _$WeaponBuildingGameEventImpl extends WeaponBuildingGameEvent {
  const _$WeaponBuildingGameEventImpl({required this.component}) : super._();

  @override
  final RotationTower component;

  @override
  String toString() {
    return 'GameEvent.weaponBuilding(component: $component)';
  }
}

abstract class WeaponBuildingGameEvent extends GameEvent {
  const factory WeaponBuildingGameEvent(
      {required final RotationTower component}) = _$WeaponBuildingGameEventImpl;
  const WeaponBuildingGameEvent._() : super._();

  RotationTower get component;
}

/// @nodoc

class _$WeaponSelectedGameEventImpl extends WeaponSelectedGameEvent {
  const _$WeaponSelectedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.weaponSelected()';
  }
}

abstract class WeaponSelectedGameEvent extends GameEvent {
  const factory WeaponSelectedGameEvent() = _$WeaponSelectedGameEventImpl;
  const WeaponSelectedGameEvent._() : super._();
}

/// @nodoc

class _$WeaponUnSelectedGameEventImpl extends WeaponUnSelectedGameEvent {
  const _$WeaponUnSelectedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.weaponUnSelected()';
  }
}

abstract class WeaponUnSelectedGameEvent extends GameEvent {
  const factory WeaponUnSelectedGameEvent() = _$WeaponUnSelectedGameEventImpl;
  const WeaponUnSelectedGameEvent._() : super._();
}

/// @nodoc

class _$WeaponBuildDoneGameEventImpl extends WeaponBuildDoneGameEvent {
  const _$WeaponBuildDoneGameEventImpl({required this.weapon}) : super._();

  @override
  final RotationTower weapon;

  @override
  String toString() {
    return 'GameEvent.weaponBuildDone(weapon: $weapon)';
  }
}

abstract class WeaponBuildDoneGameEvent extends GameEvent {
  const factory WeaponBuildDoneGameEvent(
      {required final RotationTower weapon}) = _$WeaponBuildDoneGameEventImpl;
  const WeaponBuildDoneGameEvent._() : super._();

  RotationTower get weapon;
}

/// @nodoc

class _$WeaponDestroyedGameEventImpl extends WeaponDestroyedGameEvent {
  const _$WeaponDestroyedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.weaponDestroyed()';
  }
}

abstract class WeaponDestroyedGameEvent extends GameEvent {
  const factory WeaponDestroyedGameEvent() = _$WeaponDestroyedGameEventImpl;
  const WeaponDestroyedGameEvent._() : super._();
}

/// @nodoc

class _$WeaponBlockedGameEventImpl extends WeaponBlockedGameEvent {
  const _$WeaponBlockedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.weaponBlocked()';
  }
}

abstract class WeaponBlockedGameEvent extends GameEvent {
  const factory WeaponBlockedGameEvent() = _$WeaponBlockedGameEventImpl;
  const WeaponBlockedGameEvent._() : super._();
}

/// @nodoc

class _$WeaponShowActionGameEventImpl extends WeaponShowActionGameEvent {
  const _$WeaponShowActionGameEventImpl({required this.weapon}) : super._();

  @override
  final RotationTower weapon;

  @override
  String toString() {
    return 'GameEvent.weaponShowAction(weapon: $weapon)';
  }
}

abstract class WeaponShowActionGameEvent extends GameEvent {
  const factory WeaponShowActionGameEvent(
      {required final RotationTower weapon}) = _$WeaponShowActionGameEventImpl;
  const WeaponShowActionGameEvent._() : super._();

  RotationTower get weapon;
}

/// @nodoc

class _$WeaponShowProfileGameEventImpl extends WeaponShowProfileGameEvent {
  const _$WeaponShowProfileGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.weaponShowProfile()';
  }
}

abstract class WeaponShowProfileGameEvent extends GameEvent {
  const factory WeaponShowProfileGameEvent() = _$WeaponShowProfileGameEventImpl;
  const WeaponShowProfileGameEvent._() : super._();
}

/// @nodoc

class _$EnemyMissedGameEventImpl extends EnemyMissedGameEvent {
  const _$EnemyMissedGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.enemyMissed()';
  }
}

abstract class EnemyMissedGameEvent extends GameEvent {
  const factory EnemyMissedGameEvent() = _$EnemyMissedGameEventImpl;
  const EnemyMissedGameEvent._() : super._();
}

/// @nodoc

class _$EnemyKilledGameEventImpl extends EnemyKilledGameEvent {
  const _$EnemyKilledGameEventImpl({required this.mineValue}) : super._();

  @override
  final int mineValue;

  @override
  String toString() {
    return 'GameEvent.enemyKilled(mineValue: $mineValue)';
  }
}

abstract class EnemyKilledGameEvent extends GameEvent {
  const factory EnemyKilledGameEvent({required final int mineValue}) =
      _$EnemyKilledGameEventImpl;
  const EnemyKilledGameEvent._() : super._();

  int get mineValue;
}

/// @nodoc

class _$EnemyNextWaveGameEventImpl extends EnemyNextWaveGameEvent {
  const _$EnemyNextWaveGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.enemyNextWave()';
  }
}

abstract class EnemyNextWaveGameEvent extends GameEvent {
  const factory EnemyNextWaveGameEvent() = _$EnemyNextWaveGameEventImpl;
  const EnemyNextWaveGameEvent._() : super._();
}

/// @nodoc

class _$LabGameEventImpl extends LabGameEvent {
  const _$LabGameEventImpl(this.value) : super._();

  @override
  final dynamic value;

  @override
  String toString() {
    return 'GameEvent.lab(value: $value)';
  }
}

abstract class LabGameEvent extends GameEvent {
  const factory LabGameEvent(final dynamic value) = _$LabGameEventImpl;
  const LabGameEvent._() : super._();

  dynamic get value;
}

/// @nodoc

class _$EnemyGetDamagedGameEventImpl extends EnemyGetDamagedGameEvent {
  const _$EnemyGetDamagedGameEventImpl(this.id) : super._();

  @override
  final EnemyId id;

  @override
  String toString() {
    return 'GameEvent.enemyGetDamaged(id: $id)';
  }
}

abstract class EnemyGetDamagedGameEvent extends GameEvent {
  const factory EnemyGetDamagedGameEvent(final EnemyId id) =
      _$EnemyGetDamagedGameEventImpl;
  const EnemyGetDamagedGameEvent._() : super._();

  EnemyId get id;
}

/// @nodoc

class _$EnemySpawnGameEventImpl extends EnemySpawnGameEvent {
  const _$EnemySpawnGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.enemySpawn()';
  }
}

abstract class EnemySpawnGameEvent extends GameEvent {
  const factory EnemySpawnGameEvent() = _$EnemySpawnGameEventImpl;
  const EnemySpawnGameEvent._() : super._();
}

/// @nodoc

class _$SpawnOneGameEventImpl extends SpawnOneGameEvent {
  const _$SpawnOneGameEventImpl(this.type) : super._();

  @override
  final EnemyType type;

  @override
  String toString() {
    return 'GameEvent.spawnOne(type: $type)';
  }
}

abstract class SpawnOneGameEvent extends GameEvent {
  const factory SpawnOneGameEvent(final EnemyType type) =
      _$SpawnOneGameEventImpl;
  const SpawnOneGameEvent._() : super._();

  EnemyType get type;
}

/// @nodoc

class _$NextWaveGameEventImpl extends NextWaveGameEvent {
  const _$NextWaveGameEventImpl(this.index) : super._();

  @override
  final int index;

  @override
  String toString() {
    return 'GameEvent.nextWave(index: $index)';
  }
}

abstract class NextWaveGameEvent extends GameEvent {
  const factory NextWaveGameEvent(final int index) = _$NextWaveGameEventImpl;
  const NextWaveGameEvent._() : super._();

  int get index;
}

/// @nodoc

class _$EnemyGoGameEventImpl extends EnemyGoGameEvent {
  const _$EnemyGoGameEventImpl(this.enemy) : super._();

  @override
  final Enemy enemy;

  @override
  String toString() {
    return 'GameEvent.enemyGo(enemy: $enemy)';
  }
}

abstract class EnemyGoGameEvent extends GameEvent {
  const factory EnemyGoGameEvent(final Enemy enemy) = _$EnemyGoGameEventImpl;
  const EnemyGoGameEvent._() : super._();

  Enemy get enemy;
}

/// @nodoc

class _$CreateStageGameEventImpl extends CreateStageGameEvent {
  const _$CreateStageGameEventImpl() : super._();

  @override
  String toString() {
    return 'GameEvent.createStage()';
  }
}

abstract class CreateStageGameEvent extends GameEvent {
  const factory CreateStageGameEvent() = _$CreateStageGameEventImpl;
  const CreateStageGameEvent._() : super._();
}

/// @nodoc

class _$MovePointerGlobalGameEventImpl extends MovePointerGlobalGameEvent {
  const _$MovePointerGlobalGameEventImpl(this.position) : super._();

  @override
  final Vector2 position;

  @override
  String toString() {
    return 'GameEvent.movePointerGlobal(position: $position)';
  }
}

abstract class MovePointerGlobalGameEvent extends GameEvent {
  const factory MovePointerGlobalGameEvent(final Vector2 position) =
      _$MovePointerGlobalGameEventImpl;
  const MovePointerGlobalGameEvent._() : super._();

  Vector2 get position;
}

/// @nodoc

class _$FinishPointerGlobalGameEventImpl extends FinishPointerGlobalGameEvent {
  const _$FinishPointerGlobalGameEventImpl(this.position, this.id) : super._();

  @override
  final Vector2 position;
  @override
  final WeaponId id;

  @override
  String toString() {
    return 'GameEvent.finishPointerGlobal(position: $position, id: $id)';
  }
}

abstract class FinishPointerGlobalGameEvent extends GameEvent {
  const factory FinishPointerGlobalGameEvent(
          final Vector2 position, final WeaponId id) =
      _$FinishPointerGlobalGameEventImpl;
  const FinishPointerGlobalGameEvent._() : super._();

  Vector2 get position;
  WeaponId get id;
}

/// @nodoc

class _$OnTapDownGEImpl extends OnTapDownGE {
  const _$OnTapDownGEImpl(this.position) : super._();

  @override
  final Vector2 position;

  @override
  String toString() {
    return 'GameEvent.onTapDown(position: $position)';
  }
}

abstract class OnTapDownGE extends GameEvent {
  const factory OnTapDownGE(final Vector2 position) = _$OnTapDownGEImpl;
  const OnTapDownGE._() : super._();

  Vector2 get position;
}

/// @nodoc

class _$OnTapUpGEImpl extends OnTapUpGE {
  const _$OnTapUpGEImpl(this.position) : super._();

  @override
  final Vector2 position;

  @override
  String toString() {
    return 'GameEvent.onTapUp(position: $position)';
  }
}

abstract class OnTapUpGE extends GameEvent {
  const factory OnTapUpGE(final Vector2 position) = _$OnTapUpGEImpl;
  const OnTapUpGE._() : super._();

  Vector2 get position;
}

/// @nodoc

class _$OnDragUpdateGEImpl extends OnDragUpdateGE {
  const _$OnDragUpdateGEImpl(this.position) : super._();

  @override
  final Vector2 position;

  @override
  String toString() {
    return 'GameEvent.onDragUpdate(position: $position)';
  }
}

abstract class OnDragUpdateGE extends GameEvent {
  const factory OnDragUpdateGE(final Vector2 position) = _$OnDragUpdateGEImpl;
  const OnDragUpdateGE._() : super._();

  Vector2 get position;
}
