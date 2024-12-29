import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/direction_animation.dart';


class ScannableEnemy extends ScannableUnit with DirectionAnimation {
  ScannableEnemy({
    required Vector2 position,
    required Vector2 size,
    SimpleDirectionAnimation? animation,
    double life = 100,
    double? speed,
    Direction initDirection = Direction.right,
    AcceptableAttackOriginEnum receivesAttackFrom =
        AcceptableAttackOriginEnum.PLAYER_AND_ALLY,
  }) : super(
          position: position,
          size: size,
          life: life,
          speed: speed,
          receivesAttackFrom: receivesAttackFrom,
        ) {
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
    required Vector2 position,
    required Vector2 size,
    double life = 10,
    double? speed,
    AcceptableAttackOriginEnum receivesAttackFrom =
        AcceptableAttackOriginEnum.PLAYER_AND_ALLY,
  }) : super(position: position, size: size, speed: speed) {
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
