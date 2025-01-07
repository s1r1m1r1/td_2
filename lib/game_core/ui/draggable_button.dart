import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import '../../domain/weapon_option.dart';
import '../controller/game_controller.dart';

import '../controller/game_event.dart';
import '../decoration/chest.dart';
import '../decoration/common_sprite_sheet.dart';
import '../mixin/mixin_movable.dart';
import '../mixin/mother_pointer_mixin.dart';

class DraggableButtonArena extends PositionComponent with HasVisibility {
  DraggableButtonArena(Vector2 position) {
    this.position = position;
    _textConfig = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: width / 2),
    );
  }
  TextComponent? staticText;
  GameComponent? staticImage;
  String text = 'Drag here';
  late TextPaint _textConfig;
  get textSize => _textConfig.getLineMetrics(text).size;

  @override
  FutureOr<void> onLoad() {
    staticImage = Chest(position);
    staticText = TextComponent(
      text: text,
      position: Vector2(0, 32),
      textRenderer: _textConfig,
    );
    add(staticImage!);
    add(staticText!);
    return super.onLoad();
  }
}

// class DraggableButton extends PositionComponent
//     with MixinMovable, MotherPointerListener, HasVisibility {
//   DraggableButton({
//     required super.position,
//     required Vector2 size,
//     required this.mother,
//   }) : super.withSprite(
//           sprite: CommonSpriteSheet.barrelSprite,
//           size: size / 2,
//         ) {
//     startPosition = position.clone();
//     isVisible = true;
//   }
//   late final _timer = Timer(1.0, onTick: toDefaultPosition);
//   late final Vector2 startPosition;

//   final MotherPointerMixin mother;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     mother.addListener(this); // XPointerListener
//   }

//   @override
//   void onRemove() {
//     mother.removeListener(this); // XPointerListener
//     super.onRemove();
//   }

//   @override
//   void listenPointerDown(PointerDownEvent event) {
//     _timer.start();
//     isVisible = true;
//     isDragging = true;
//   }

//   @override
//   void listenPointerMove(PointerMoveEvent event) {
//     if (!_timer.isRunning()) {
//       _timer.start();
//       isDragging = true;
//     }
//     position = position + event.delta.toVector2();
//     GameController.event(GameEvent.movePointerGlobal(
//         event.position.toVector2() - mother.marginVec2));
//     _timer.reset();
//   }

//   @override
//   void listenPointerUp(PointerUpEvent event) {
//     toDefaultPosition();
//     GameController.event(GameEvent.finishPointerGlobal(
//         event.position.toVector2() - mother.marginVec2, const WeaponId(0)));
//   }

//   void toDefaultPosition() {
//     _timer.stop();
//     isDragging = false;
//     position = startPosition;
//   }

//   @override
//   void update(double dt) {
//     if (_timer.isRunning()) {
//       _timer.update(dt);
//     }
//     super.update(dt);
//   }
// }
