import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:logging/logging.dart';
import 'package:td_2/game_core/other/priority.dart';

import '../unit/tower/towers.dart';
import 'stage_map.dart';
import 'x_tile.dart';

enum TowerType { missile, rocket }

final _log = Logger(TileComponent.loggerName);

class StartGateTileComponent extends TileComponent {
  StartGateTileComponent({
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
        position: position,
        size: size,
        paint: Paint()..color = Colors.purple,
        children: [TextComponent(position: Vec2.zero, text: "Start")]);
    gameRef.add(startGate!);
  }

  @override
  void onRemove() {
    startGate?.removeFromParent();
    super.onRemove();
  }
}

class EndGateTileComponent extends TileComponent {
  EndGateTileComponent({
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
        position: position,
        size: size,
        paint: Paint()..color = Colors.purple,
        children: [TextComponent(position: Vec2.zero, text: "END")]);
    gameRef.add(endGate!);
  }

  @override
  void onRemove() {
    endGate?.removeFromParent();
    super.onRemove();
  }
}

class FoundationTileComponent extends TileComponent {
  FoundationTileComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });

  void setTower(RotationTower tower) {
    super.setChild(tower);
  }

  void removeTower() {
    super.removeChild();
  }

  bool get hasTower => super.hasChild;
}

class RoadTileComponent extends TileComponent {
  RoadTileComponent({
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

sealed class TileComponent extends GameComponent {
  static const loggerName = "TileComponent";
  TileComponent({
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

  GameComponent? decoration;
  GameComponent? child;
  GameComponent? drawing;

  bool isCover(Vector2 pos) {
    final rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    _log.info('isCover rect: $rect');
    _log.info('isCover pos: $pos');
    _log.info('isCover contains: ${rect.contains(pos.toOffset())}');
    return rect.contains(pos.toOffset());
  }

  void setChild(GameComponent component) {
    child = component;
    gameRef.add(component);
  }

  void removeChild() {
    child?.removeFromParent();
    child = null;
  }

  bool get hasChild => child != null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    decoration =
        XTile(position: position, size: Vector2.all(StageMap.tileSize * 0.8));

    gameRef.add(decoration!);
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
