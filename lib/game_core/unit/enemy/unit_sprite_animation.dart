import 'dart:async';
import 'package:bonfire/bonfire.dart';

import '../../mixin/mixin_future_loader.dart';
import '../../mixin/mixin_sprite_animation.dart';
// import '../../mixin/mixin_sprite_animation.dart';

class UnitSpriteAnimation extends PositionComponent
    with MixinSpriteAnimation, MixinFutureLoader {
  UnitSpriteAnimation({
    required super.position,
    required super.size,
    required Future<SpriteAnimation> futureAnim,
  }) {
    // final img = Images();
    loader?.add(FutureToLoad(futureAnim, setAnimation));
  }
}
