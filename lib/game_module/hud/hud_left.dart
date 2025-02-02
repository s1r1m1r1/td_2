import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../generated/assets.gen.dart';
import '../core/process_game.dart';
import '../other/priority.dart';

class HudLeft extends PositionComponent
    with TapCallbacks, HasGameReference<ProcessGame> {
  HudLeft({required super.position, required super.size});

  @override
  set priority(int newPriority) {
    super.priority = Priority.overAll + 1;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final sprite = await Sprite.load(Assets.images.weapon.cannon.path);
    add(
      SpriteComponent(
        position: Vector2.all(20),
        sprite: sprite,
        size: Vector2.all(size.x - 20),
        autoResize: false,
      ),
    );
    add(FpsTextComponent());
    game.addPanIgnore(this);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!game.enableHudNotifier.value) return;
    print('On LEFT Tap Down');
    game.audioPlayer.play(AssetSource(Assets.audio.sfx.fire1));
    // decorator.addLast(PaintDecorator.blur(0.2));
    // decorator.addLast(Rotate3DDecorator());
    // scale = Vector2.all(10);
    super.onTapDown(event);

    @override
    void onTapCancel(TapCancelEvent event) {
      if (!game.enableHudNotifier.value) return;
      // scale = Vector2.all(2.0);
      super.onTapCancel(event);
    }

    @override
    void onTapUp(TapUpEvent event) {
      if (!game.enableHudNotifier.value) return;
      game.audioPlayer.play(AssetSource(Assets.audio.sfx.fire1));
      decorator.removeLast();
      print('On TAP UP LEFT');
      super.onTapUp(event);
    }
  }
}
