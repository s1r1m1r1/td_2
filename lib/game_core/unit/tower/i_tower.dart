import 'package:bonfire/bonfire.dart';

class ITowerComponent extends GameComponent {
  ITowerComponent({
    required Vector2 position,
    required Vector2 size,
    double? speed,
  }) {
    this.position = position;
    this.size = size;
  }
}
