import 'package:flutter/foundation.dart';

mixin MixinHealth {
  double _health = 1;
  double _maxHealth = 1;
  double get health => _health;
  double get maxHealth => _maxHealth;
  bool _alive = true;

  @mustCallSuper
  void setHealth(double value) {
    _health = value;
    _maxHealth = value;
  }

  @mustCallSuper
  void subtractHealth(double value) {
    if (value > _health) {
      _health = 0;
    } else {
      _health -= value;
    }
    _verifyLimits();
  }

  @mustCallSuper
  void addHealth(double value) {
    _health += value;
    if (_health > _maxHealth) _maxHealth = _health;
    _verifyLimits();
  }

  void _verifyLimits() {
    if (_health > 0) return;
    _alive = false;
  }

  bool get isDead => !_alive;
}
