import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';

class TowerRotateEffect extends RotateEffect {
  final VoidCallback? _onComplete;
  TowerRotateEffect(
    double radians,
    EffectController controller,
    void Function()? onComplete,
  )   : _destinationAngle = radians,
        _onComplete = onComplete,
        super.by(0, controller);

  double _angle = 0;
  final double _destinationAngle;

  @override
  void onStart() {
    _angle = _destinationAngle - target.angle;
    if (_angle > pi) {
      _angle = _angle - (pi * 2);
    }
    if (_angle < -pi) {
      _angle = _angle + (pi * 2);
    }
  }

  @override
  void onFinish() {
    super.onFinish();
    if (target.angle < 0) {
      target.angle += pi * 2;
    }
    if (target.angle > (pi * 2)) {
      target.angle -= pi * 2;
    }
    _onComplete?.call();
  }

  @override
  void apply(double progress) {
    final dProgress = progress - previousProgress;
    target.angle += _angle * dProgress;
    super.apply(progress);
  }
}
