import 'package:bonfire/bonfire.dart';

class TowerSpriteSheet {
  static Future<SpriteAnimation> cannonSprite() {
    return Sprite.load('weapon/Cannon.png').toAnimation();
  }
  static Future<SpriteAnimation> missileSprite() {
    return Sprite.load('weapon/Missile_Launcher.png').toAnimation();
  }

  static Future<SpriteAnimation> gun2Sprite() {
    return Sprite.load('weapon/Cannon2.png').toAnimation();
  }

  static Future<Sprite> gun3Sprite() {
    return Sprite.load('weapon/Cannon3.png');
  }

  static Future<SpriteAnimation> tower() {
    return Sprite.load('weapon/Tower.png').toAnimation();
  }

  static Future<SpriteAnimation> bulletMG() {
    return Sprite.load('weapon/Bullet_MG.png').toAnimation();
  }

  static Future<SpriteAnimation> bullet1() {
    return Sprite.load('weapon/Bullet1.png').toAnimation();
  }

  static Future<SpriteAnimation> bullet2() {
    return Sprite.load('weapon/Bullet2.png').toAnimation();
  }

  static Future<SpriteAnimation> missile() {
    return Sprite.load('weapon/Missile.png').toAnimation();
  }
}
