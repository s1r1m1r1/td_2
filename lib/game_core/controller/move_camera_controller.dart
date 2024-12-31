import 'package:bonfire/bonfire.dart';
import 'package:flutter/gestures.dart';

import '../mixin/mother_pointer_mixin.dart';

class MoveCameraController extends GameComponent with MotherPointerMixin {
  Vector2 _startPoint = Vector2.zero();
  Vector2 _startCameraPosition = Vector2.zero();
  bool _onlyMouse = false;
  MouseButton _mouseButton = MouseButton.left;

  @override
  bool handlerPointerDown(PointerDownEvent event) {
    final booL = super.handlerPointerDown(event);
    if (booL) {
      return false;
    }
    _startPoint = event.position.toVector2();
    _startCameraPosition = gameRef.camera.position;
    return false;
  }

  @override
  bool handlerPointerMove(PointerMoveEvent event) {
    final booL = super.handlerPointerMove(event);
    if (booL) {
      return false;
    }

    double distance = _startPoint.distanceTo(event.position.toVector2());
    if (distance > 1) {
      if (_acceptGesture(event, _mouseButton)) {
        double zoom = gameRef.camera.zoom;
        double px = _startPoint.x - event.position.dx;
        double py = _startPoint.y - event.position.dy;
        gameRef.camera.stop();
        gameRef.camera.moveTo(
          _startCameraPosition.translated(
            px / zoom,
            py / zoom,
          ),
        );
        return false;
      }
    }

    return false;
  }

  bool _acceptGesture(PointerEvent event, MouseButton button) {
    bool isMouse = event.kind == PointerDeviceKind.mouse;

    if (_onlyMouse) {
      return event.buttons == button.id && isMouse;
    } else {
      if (isMouse) {
        return event.buttons == button.id;
      }
      return true;
    }
  }

  @override
  bool hasGesture() => true;

  @override
  bool get isVisible => true;
}
