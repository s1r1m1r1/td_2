import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../mixin/clash/mixin_clash.dart';
import '../../mixin/clash/mixin_clash_config.dart';
import '../../other/priority.dart';

class ExplosionComponent extends GameComponent with MixinClash {
  ExplosionComponent({
    required Vector2 position,
    required Vector2 size,
    required Anchor anchor,
  }) {
    this.position = position;
    this.size = size;
    this.anchor = anchor;
  }

  @override
  MixinClashConfig clashConfig = const MixinClashConfig(mode: ClashMode.collision, effect: 50);

  @override
  Future<void> onLoad() {
    add(RectangleComponent(
      position: Vector2(0, 0),
      priority: 1000,
      paint: Paint()..color = Colors.yellow.withAlpha(100),
      anchor: Anchor.topLeft,
      size: size,
    )..add(RemoveEffect(delay: 1)));
    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   if (_shouldDisable) {
  //     super.disableClash();
  //   }
  //   super.update(dt);
  // }

  @override
  int get priority => Priority.tileTower;

  @override
  void clashAlert() {
    // debugPrint('disable Clash 0jgls');
    disableClash();
    // _shouldDisable = true;
  }
}
