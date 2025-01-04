import 'package:bonfire/bonfire.dart';

mixin MixinHealth on Component {
  abstract double health;
  bool _alive = true;

  void subtractHealth(double value) {
    if (value > health) {
      health = 0;
    } else {
      health -= value;
    }
    _verifyLimits();
  }

  void _verifyLimits() {
    if (health > 0) return;
    _alive = false;
  }

  bool get isDead => !_alive;
}
