import '../../generated/assets.gen.dart';

enum FloorZone { enemySpawn, playerStart, none }

enum FloorType {
  none,
  flat,
  flat2,
  hill,
  mont,
  water,

  mount1,
  mount2,
  mount3,
  grass1,
  grass2,
  grass3;

  String get asset => switch (this) {
        FloorType.flat => Assets.images.weapon.cannon.path,
        FloorType.flat2 => Assets.images.weapon.cannon.path,
        FloorType.hill => Assets.images.weapon.cannon.path,
        FloorType.mont => Assets.images.weapon.cannon.path,
        FloorType.water => Assets.images.weapon.cannon.path,
        FloorType.mount1 => Assets.images.weapon.cannon.path,
        FloorType.mount2 => Assets.images.weapon.cannon.path,
        FloorType.mount3 => Assets.images.weapon.cannon.path,
        FloorType.grass1 => Assets.images.weapon.cannon.path,
        FloorType.grass2 => Assets.images.weapon.cannon.path,
        FloorType.grass3 => Assets.images.weapon.cannon.path,
        FloorType.none => Assets.images.weapon.cannon.path,
      };
}
