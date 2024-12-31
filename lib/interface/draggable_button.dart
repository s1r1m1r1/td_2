import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:td_2/controller/game_controller.dart';
import 'package:td_2/unit/mixin/mother_pointer_mixin.dart';

import '../decoration/chest.dart';
import '../controller/game_event.dart';
import '../tile/stage_map.dart';
import '../decoration/common_sprite_sheet.dart';

class DraggableButton extends GameDecoration
    with Movement, BlockMovementCollision, MotherPointerListener {
  late TextPaint _textConfig;

  String text = 'Drag here';
  get textSize => _textConfig.getLineMetrics(text).size;
  TextComponent? staticText;
  GameComponent? staticImage;
  late final Vector2 _defaultPosition;

  DraggableButton(Vector2 position)
      : super.withSprite(
          sprite: CommonSpriteSheet.barrelSprite,
          position: position,
          size: Vector2.all(StageMap.tileSize),
        ) {
    _defaultPosition = position;
    _textConfig = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: width / 2),
    );
  }

  MotherPointerMixin? get motherPointer =>
      gameRef.query<MotherPointerMixin>().firstOrNull;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    motherPointer?.addListener(this); // XPointerListener
  }

  @override
  void onRemove() {
    motherPointer?.removeListener(this); // XPointerListener
    super.onRemove();
  }

  @override
  void listenPointerDown(PointerDownEvent event) {
    debugPrint('LISTEN pointer down');
    staticImage = Chest(position);
    staticText = TextComponent(
      text: text,
      position: Vector2(0, 32),
      textRenderer: _textConfig,
    );
    parent?.add(staticImage!);
    staticImage?.add(staticText!);
  }

  @override
  void listenPointerMove(PointerMoveEvent event) {
    debugPrint('LISTEN pointer move');
    position = position + event.delta.toVector2();
  }

  @override
  void listenPointerUp(PointerUpEvent event) {
    staticImage?.removeFromParent();
    staticText?.removeFromParent();
    position = _defaultPosition;
    final localPos = gameRef.camera.globalToLocal(event.position.toVector2());
    GameController.event(GameEvent.finishDragButton(localPos));
  }
}
