import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../mixin/clash.dart';
import '../../other/priority.dart';

class Explosion extends GameComponent with Clash {
  Explosion({
    required Vector2 position,
    required Vector2 size,
  }) {
    this.position = position;
    this.size = size;
  }
  @override
  get effect => 50;

  @override
  final mode = ClashMode.clashAll;

  @override
  Future<void> onLoad() {
    add(RectangleComponent(
      priority: 1000,
      paint: Paint()..color = Colors.yellow.withAlpha(100),
      anchor: Anchor.center,
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