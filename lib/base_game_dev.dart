import 'package:bonfire/bonfire.dart';
import 'package:bonfire/collision/quad_tree/custom_has_quadtree_collision_detection.dart';
import 'package:bonfire/mixins/pointer_detector.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// CustomBaseGame created to use `Listener` to capture touch screen gestures.
/// Apply zoom in canvas.
/// Reorder components per time frame.
abstract class BaseGameDev extends FlameGame
    with
        PointerDetector,
        KeyboardEvents,
        CustomHasQuadTreeCollisionDetection,
        HasTimeScale {
  BaseGameDev({super.world, super.camera});
  bool enabledGestures = true;
  bool enabledKeyboard = true;
  Iterable<PointerDetectorHandler> _gesturesComponents = [];

  @override
  void updateTree(double dt) {
    _gesturesComponents = [...world.children, ...camera.viewport.children]
        .whereType<PointerDetectorHandler>();
    super.updateTree(dt);
  }

  /// to get the components that contain gestures
  Iterable<KeyboardEventListener> get _keyboardComponents {
    return [
      ...world.children.query<KeyboardEventListener>(),
      ...camera.viewport.children.query<Keyboard>(),
    ];
  }

  @override
  void onPointerCancel(PointerCancelEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerCancel(event)) {
        return;
      }
    }
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerUp(event)) {
        return;
      }
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerMove(event)) {
        return;
      }
    }
  }

  @override
  void onPointerDown(PointerDownEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerDown(event)) {
        return;
      }
    }
  }

  @override
  void onPointerHover(PointerHoverEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerHover(event)) {
        return;
      }
    }
  }

  @override
  void onPointerSignal(PointerSignalEvent event) {
    if (!hasLayout || !enabledGestures) {
      return;
    }
    for (final c in _gesturesComponents) {
      if (c.handlerPointerSignal(event)) {
        return;
      }
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    var result = KeyEventResult.ignored;
    if (!enabledKeyboard) {
      return result;
    }
    for (final listener in _keyboardComponents) {
      if (listener.onKeyboard(event, keysPressed)) {
        result = KeyEventResult.handled;
      }
    }
    return result;
  }

  @override
  void onRemove() {
    super.onRemove();
    removeAll(children);
    processLifecycleEvents();
  }
}
