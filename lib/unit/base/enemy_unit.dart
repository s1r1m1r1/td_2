import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/direction_animation.dart';


class ScannableEnemy extends ScannableUnit with DirectionAnimation {
  ScannableEnemy({
    required super.position,
    required super.size,
    SimpleDirectionAnimation? animation,
    super.life = 100,
    super.speed,
    Direction initDirection = Direction.right,
    super.receivesAttackFrom,
  }) {
    this.animation = animation;
    lastDirection = initDirection;
    lastDirectionHorizontal =
        initDirection == Direction.left ? Direction.left : Direction.right;
  }

  // @override
  bool isActive = true;

  
}

class ScannableUnit extends Unit with Attackable {
  ScannableUnit({
    required super.position,
    required super.size,
    double life = 10,
    super.speed,
    AcceptableAttackOriginEnum receivesAttackFrom =
        AcceptableAttackOriginEnum.PLAYER_AND_ALLY,
  }) {
    this.receivesAttackFrom = receivesAttackFrom;
    initialLife(life);
  }
}

class Unit extends GameComponent with Movement, Vision {
  Unit({
    required Vector2 position,
    required Vector2 size,
    double? speed,
  }) {
    this.speed = speed ?? this.speed;
    this.position = position;
    this.size = size;
  }
}
