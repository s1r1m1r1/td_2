import 'package:flame/components.dart';

import '../../../generated/assets.gen.dart';

class TowerSpriteSheet {
  static Future<Sprite> cannonSprite() {
    return Sprite.load(
      Assets.images.weapon.cannon.path,
    );
  }

  static Future<Sprite> missileSprite() {
    return Sprite.load(
      Assets.images.weapon.missileLauncher.path,
    );
  }

  static Future<Sprite> gun2Sprite() {
    return Sprite.load(
      Assets.images.weapon.cannon2.path,
    );
  }

  static Future<Sprite> gun3Sprite() {
    return Sprite.load(
      Assets.images.weapon.cannon3.path,
    );
  }

  static Future<Sprite> tower() {
    return Sprite.load(
      Assets.images.weapon.tower.path,
    );
  }

  static Future<Sprite> bulletMG() {
    return Sprite.load(
      Assets.images.weapon.bulletMG.path,
    );
  }

  static Future<Sprite> bullet1() {
    return Sprite.load(
      Assets.images.weapon.bullet1.path,
    );
  }

  static Future<Sprite> bullet2() {
    return Sprite.load(
      Assets.images.weapon.bullet2.path,
    );
  }

  static Future<Sprite> missile() {
    return Sprite.load(
      Assets.images.weapon.missile.path,
    );
  }
}
