import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Colors, debugPrint;
import 'package:flutter/painting.dart' show Paint;

import '../../domain/weapon_option.dart';
import '../../generated/assets.gen.dart';
import '../controller/game_event.dart';
import '../core/process_game.dart';
import '../other/priority.dart';

class DragWeapon extends RectangleComponent with HasVisibility {
  DragWeapon({super.position, super.size, super.paint});
}

class HudWeaponItem extends PositionComponent
    with DragCallbacks, TapCallbacks, HasGameReference<ProcessGame> {
  HudWeaponItem({
    required super.position,
    required super.size,
  });
  late Vector2 defaultPosition;
  late DragWeapon dragTarget;

  @override
  set priority(int newPriority) {
    super.priority = Priority.overAll + 1;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    defaultPosition = position.clone();
    dragTarget = DragWeapon(paint: Paint()..color = Colors.red, size: size);
    dragTarget.isVisible = false;
    add(dragTarget);
    final sprite = await Sprite.load(Assets.images.weapon.cannon.path);
    add(
      SpriteComponent(
        position: Vector2.all(20),
        sprite: sprite,
        size: Vector2.all(size.x - 20),
        autoResize: false,
      ),
    );
    game.addPanIgnore(this);
  }

  @override
  void onDragStart(DragStartEvent event) {
    debugPrint(' ON DRAG START $runtimeType');
    dragTarget.isVisible = true;
    dragTarget.position
      ..x = 0
      ..y = 0;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    dragTarget.position.translate(event.canvasDelta.x, event.canvasDelta.y);

    final pos = dragTarget.absolutePosition;
    game.addEvent(GameEvent.movePointerGlobal(pos));
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    final pos = dragTarget.absolutePosition;
    game.addEvent(GameEvent.finishPointerGlobal(pos,const WeaponId(1)));
    dragTarget.position
      ..x = 0
      ..y = 0;
    dragTarget.isVisible = false;
    position = defaultPosition;
    super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    position = defaultPosition;
    super.onDragCancel(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!game.enableHudNotifier.value) return;
    game.audioPlayer.play(AssetSource(Assets.audio.sfx.fire1));
    // decorator.addLast(PaintDecorator.blur(0.2));
    // decorator.addLast(Rotate3DDecorator());
    // scale = Vector2.all(10);
    super.onTapDown(event);
  }

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
