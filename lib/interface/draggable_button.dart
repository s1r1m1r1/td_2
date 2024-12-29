import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../decoration/chest.dart';
import '../controller/game_event.dart';
import '../controller/static_controller.dart';
import '../world/stage_map.dart';
import '../decoration/common_sprite_sheet.dart';

class DraggableButton extends GameDecoration
    with DragGesture, Movement, BlockMovementCollision {
  late TextPaint _textConfig;

  String text = 'Drag here';
  get textSize => _textConfig.getLineMetrics(text).size;
  TextComponent? staticText;
  GameComponent? staticImage;

  DraggableButton(Vector2 position)
      : super.withSprite(
          sprite: CommonSpriteSheet.barrelSprite,
          position: position,
          size: Vector2.all(StageMap.tileSize),
        ) {
    _textConfig = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: width / 2),
    );
  }

  bool _isPointerCover(PointerEvent event) {
    final rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    return rect.contains(event.position);
  }

  @override
  bool handlerPointerDown(PointerDownEvent event) {
    final isCover = _isPointerCover(event);
    if (!isCover) return false;

    staticImage = Chest(position);
    staticText = TextComponent(
      text: text,
      position: Vector2(0, 32),
      textRenderer: _textConfig,
    );
    parent?.add(staticImage!);
    staticImage?.add(staticText!);
    return super.handlerPointerDown(event);
  }

  @override
  bool handlerPointerUp(PointerUpEvent event) {
    final isCover = _isPointerCover(event);
    if (!isCover) return false;

    if (staticImage != null) {
      position = staticImage!.position;
      staticImage!.removeFromParent();
    }
    staticText?.removeFromParent();

    final localPos = gameRef.camera.globalToLocal(event.position.toVector2());
    staticController.add(GameEvent.setDraggable(localPos));
    return super.handlerPointerUp(event);
  }
}
