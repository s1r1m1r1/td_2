import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:logging/logging.dart';

import '../../game_dev.dart';
import '../core/process_game.dart';
import '../other/priority.dart';
import '../other/stage_map.dart';
import '../unit/tower/towers.dart';
import 'x_tile.dart';

enum TowerType { missile, rocket }

final _log = Logger(FloorComponent.loggerName);

class StartGateFloorComponent extends FloorComponent {
  StartGateFloorComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });
  Component? startGate;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    startGate = RectangleComponent(
        priority: Priority.overAll,
        size: size,
        paint: Paint()..color = Colors.purple.withAlpha(100),
        children: [TextComponent(position: Vec2.zero, text: "Start")]);
    add(startGate!);
  }

  @override
  void onRemove() {
    startGate?.removeFromParent();
    super.onRemove();
  }
}

class EndGateFloorComponent extends FloorComponent {
  EndGateFloorComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });
  Component? endGate;

  @override
  Future<void> onLoad() async {
    _log.info("ON LOAD");
    await super.onLoad();
    endGate = RectangleComponent(
        priority: Priority.overAll,
        size: size,
        paint: Paint()..color = Colors.purple.withAlpha(100),
        children: [TextComponent(position: Vec2.zero, text: "END")]);
    add(endGate!);
  }

  @override
  void onRemove() {
    endGate?.removeFromParent();
    super.onRemove();
  }
}

class FoundationFloorComponent extends FloorComponent {
  FoundationFloorComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });

  void setTower(RotationTower tower) {
    tower.size = size;
    super.setChild(tower);
  }

  void removeTower() {
    super.removeChild();
  }

  bool get hasTower => super.hasChild;
}

class RoadFloorComponent extends FloorComponent {
  RoadFloorComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });

  @override
  Future<void> onLoad() {
    add(RectangleComponent(
        size: size,
        paint: Paint()..color = Colors.white24,
        priority: Priority.overAll));
    return super.onLoad();
  }
}

sealed class FloorComponent extends PositionComponent
    with HasGameReference<ProcessGame> {
  static const loggerName = "FloorComponent";
  FloorComponent({
    required Vector2 size,
    required Vector2 position,
    required this.gridPos,
  }) {
    _log.info('added $gridPos');
    this.size = size;
    this.position = position;
  }
  @override
  int get priority => 20;

  final Point<int> gridPos;

  PositionComponent? decoration;
  PositionComponent? child;
  PositionComponent? drawing;

  bool isCover(Vector2 pos) {
    final rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    _log.info('isCover rect: $rect');
    _log.info('isCover pos: $pos');
    _log.info('isCover contains: ${rect.contains(pos.toOffset())}');
    return rect.contains(pos.toOffset());
  }

  void setChild(PositionComponent component) {
    child = component;
    game.world.add(component);
  }

  void removeChild() {
    child?.removeFromParent();
    child = null;
  }

  bool get hasChild => child != null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    decoration = XTile(size: Vector2.all(StageMap.tileSize * 0.8));

    add(decoration!);
    // gameRef.add(decoration2!);
  }

  @override
  void onRemove() {
    decoration?.removeFromParent();
    child?.removeFromParent();
    decoration = null;
    child = null;
    super.onRemove();
  }
}
