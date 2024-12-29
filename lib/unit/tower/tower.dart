import 'package:bonfire/bonfire.dart';

class TowerComponent extends GameComponent with Vision {
  TowerComponent({
    required Vector2 position,
    required Vector2 size,
    double? speed,
  }) {
    this.position = position;
    this.size = size;
  }
}
