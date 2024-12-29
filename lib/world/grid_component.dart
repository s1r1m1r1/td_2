import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:td_2/render/priority.dart';
import 'package:td_2/unit/tower/tower_component.dart';

import 'stage_map.dart';
import '../decoration/x_tile.dart';

enum TowerType { missile, rocket }

class StartGateTileComponent extends TileComponent {
  StartGateTileComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });
}

class EndGateTileComponent extends TileComponent {
  EndGateTileComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });
}

class FoundationTileComponent extends TileComponent {
  FoundationTileComponent({
    required super.size,
    required super.position,
    required super.gridPos,
  });

  void setTower(TowerType type) {
    final component = switch (type) {
      TowerType.missile => MissileTower(position: position),
      TowerType.rocket => RocketTower(position: position),
    };
    super.setChild(component);
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
}

abstract class TileComponent extends GameComponent {
  static const loggerName = "TileComponent";
  static final _log = Logger(loggerName);
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
  GameComponent? decoration2;
  GameComponent? child;
  GameComponent? drawing;

  void setNotAllowedFX() {
    gameRef.add(
      RectangleComponent(
          position: position,
          priority: Priority.overAll,
          size: size,
          paint: Paint()..color = Colors.red.withAlpha(50))
        ..add(
          RemoveEffect(delay: 0.016),
        ),
    );
  }

  void setAllowedFX() {
    gameRef.add(
      RectangleComponent(
          priority: Priority.overAll,
          position: position,
          size: size,
          paint: Paint()..color = Colors.green.withAlpha(50))
        ..add(
          RemoveEffect(delay: 0.016),
        ),
    );
  }

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
    // decoration2 = GameDecoration.withSprite(
    //   sprite: Sprite.load('itens/flag_red.png'),
    //   position: position,
    //   size: Vector2.all(StageMap.tileSize * 1.1),
    // );
    // decoration?.priority = 3000;
    // decoration2?.priority = 9999;
    gameRef.add(decoration!);
    // gameRef.add(decoration2!);
  }

  @override
  void onRemove() {
    decoration?.removeFromParent();
    decoration2?.removeFromParent();
    child?.removeFromParent();
    decoration = null;
    decoration2 = null;
    child = null;
    super.onRemove();
  }
}
