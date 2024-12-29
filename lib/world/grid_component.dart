import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:logging/logging.dart';
import 'package:td_2/unit/tower/tower_component.dart';

import 'stage_map.dart';
import '../unit/tower/tower.dart';
import '../decoration/x_tile.dart';

class GridComponent extends GameComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    List.generate(10, (indexRow) {
      return List.generate(10, (indexColumn) {
        final g = GridTileComponent(
            position: StageMap.getRelativeTilePosition(indexRow, indexColumn),
            size: Vector2.all(StageMap.tileSize),
            gridPos: Point(indexRow, indexColumn));
        parent?.add(g);
      });
    });
  }
}

enum TowerType { missile, rocket }

class GridTileComponent extends GameComponent {
  static const loggerName = "GridTileComponent";
  static final _log = Logger(loggerName);
  GridTileComponent({
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
  TowerComponent? tower;

  bool isCover(Vector2 pos) {
    final rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    _log.info('isCover rect: $rect');
    _log.info('isCover pos: $pos');
    _log.info('isCover contains: ${rect.contains(pos.toOffset())}');
    return rect.contains(pos.toOffset());
  }

  void setTower(TowerType type) {
    switch (type) {
      case TowerType.missile:
        tower = MissileTower(position: position);
      case TowerType.rocket:
        tower = RocketTower(position: position);
    }
    gameRef.add(tower!);
  }

  void removeTower() {
    tower?.removeFromParent();
    tower = null;
  }

  bool get hasTower => tower != null;

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
    tower?.removeFromParent();
    decoration = null;
    decoration2 = null;
    tower = null;
    super.onRemove();
  }
}
