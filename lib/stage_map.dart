import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/base/layer.dart';
import 'ui/draggable_button.dart';
import 'chest.dart';
import 'spikes.dart';
import 'units/tower/tower_component.dart';

abstract class Vec2 {
  static final zero = Vector2.zero();
}

class StageMap {
  static double tileSize = 45;
  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallRight = 'tile/wall_right.png';
  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

  static void generateMap(
    List<Tile> tileList,
    int indexRow,
    int indexColumn,
    String pngImage,
  ) {
    tileList.add(
      Tile(
        sprite: TileSprite(path: pngImage),
        x: indexColumn.toDouble(),
        y: indexRow.toDouble(),
        collisions: [RectangleHitbox(size: Vector2(tileSize, tileSize))],
        width: tileSize,
        height: tileSize,
      ),
    );
  }

  static WorldMap map() {
    List<Tile> tileList = [];
    List.generate(10, (indexRow) {
      List.generate(10, (indexColumn) {
        tileList.add(
          Tile(
            sprite: TileSprite(path: randomFloor()),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            width: tileSize,
            height: tileSize,
          ),
        );
      });
    });

    return WorldMap([Layer(id: 0, tiles: tileList)]);
  }

  static List<GameDecoration> decorations() {
    return [
      Spikes(
        getRelativeTilePosition(0, 0),
      ),
      DraggableButton(getRelativeTilePosition(4, 4)),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/barrel.png'),
        position: getRelativeTilePosition(0, 2),
        size: Vector2(tileSize, tileSize),
        collisions: [
          RectangleHitbox(size: Vector2(tileSize / 1.5, tileSize / 1.5))
        ],
      ),
      Chest(getRelativeTilePosition(0, 3)),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(0, 4),
        size: Vector2(tileSize, tileSize),
        collisions: [
          RectangleHitbox(size: Vector2(tileSize, tileSize * 0.8)),
        ],
      ),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(0, 4),
        size: Vector2(tileSize, tileSize),
        collisions: [
          RectangleHitbox(size: Vector2(tileSize, tileSize * 0.8)),
        ],
      ),
      // Torch(getRelativeTilePosition(0, 5)),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(0, 6),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(0, 7),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/prisoner.png'),
        position: getRelativeTilePosition(0, 8),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(0, 9),
        size: Vector2(tileSize, tileSize),
      ),
      // ...List.generate(10, (indexRow) {
      //   return List.generate(10, (indexColumn) {
      //     return XTile(getRelativeTilePosition(indexRow, indexColumn));
      //   });
      // }).expand((i) => i).toList(),
    ];
  }

  static List<GameComponent> enemies() {
    return [
      // Goblin(getRelativeTilePosition(3, 3)),
      MissileTower(position: getRelativeTilePosition(5, 5)),

    ];
  }

  static String randomFloor() {
    int p = Random().nextInt(6);
    switch (p) {
      case 0:
        return floor_1;
      case 1:
        return floor_2;
      case 2:
        return floor_3;
      case 3:
        return floor_4;
      case 4:
        return floor_3;
      case 5:
        return floor_4;
      default:
        return floor_1;
    }
  }

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
