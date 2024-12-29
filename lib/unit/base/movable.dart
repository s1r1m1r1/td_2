import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:td_2/unit/base/math_ext.dart';

mixin Movable on GameComponent {
  double speed = 0;
  Function? onMoveFinish;
  bool _finish = true;

  Vector2 _direction = Vector2.zero();
  double _totalLength = 0;
  double _movedLength = 0;

  void moveToByDistance({
    required Vector2 to,
    required double distance,
  }) {
    angle = position.angleNearTo(to);
    final from = position;
    final double dx = to.x - from.x;
    final double dy = to.y - from.y;
    _direction = Vector2(dx / distance, dy / distance);
    _totalLength = distance;
    _movedLength = 0;
    _finish = false;
  }

  void moveFromTo(Vector2 from, Vector2 to) {
    // Vector2 = from;
    final double dx = to.x - from.x;
    final double dy = to.y - from.y;

    final double dl = sqrt(pow(dx, 2) + pow(dy, 2));
    _totalLength = dl;
    _direction = Vector2(dx / dl, dy / dl);
    _movedLength = 0;
    _finish = false;
    // onMoveFinish = onFinish;
    angle = position.angleNearTo(to);
  }

  void updateMovable(double t) {
    // super.update(t);
    if (!_finish) {
      /*finish on the next tick,  to make sure the Vector2 is able to be sensored*/
      if (_movedLength > _totalLength) {
        /*finish on the next tick,  to make sure the Vector2 is able to be sensored*/
        moveFinish();
      }
      final delta = t * speed;
      final dx = delta * _direction.x;
      final dy = delta * _direction.y;
      //overwirte Vector2 to make sure it update area.
      position = position + Vector2(dx, dy);
      //OPT: check only after time expire, to avoid pow cacl in very tick
      _movedLength += sqrt(pow(dx, 2) + pow(dy, 2));
    }
  }

  void moveFinish() {
    _finish = true;
    onMoveFinish?.call();
  }
}
