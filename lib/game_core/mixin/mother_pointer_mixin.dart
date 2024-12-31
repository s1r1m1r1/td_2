import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

mixin MotherPointerListener on GameComponent {
  bool enableDrag = true;

  void listenPointerDown(PointerDownEvent event) {}

  void listenPointerMove(PointerMoveEvent event) {}

  void listenPointerUp(PointerUpEvent event) {}

  void listenPointerCancel(PointerCancelEvent event) {}

  void listenPointerHover(PointerHoverEvent event) {}
}

mixin MotherPointerMixin on GameComponent {
  final _listener = <MotherPointerListener>[];

  void addListener(MotherPointerListener listener) {
    _listener.add(listener);
  }

  void removeListener(MotherPointerListener listener) {
    _listener.remove(listener);
  }

  @override
  void remove(Component component) {
    _listener.clear();
    super.remove(component);
  }

  bool _isPointerCover(PointerEvent event, GameComponent c) {
    final screenPos = c.absolutePosition;
    final rect = Rect.fromLTWH(screenPos.x, screenPos.y, c.size.x, c.size.y);
    return rect.contains(event.position);
  }

  @override
  bool handlerPointerDown(PointerDownEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      final isCover = _isPointerCover(event, i);
      if (isCover) {
        i.listenPointerDown(event);
        return true;
      }
    }
    return false;
  }

  @override
  bool handlerPointerUp(PointerUpEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      final isCover = _isPointerCover(event, i);
      if (isCover) {
        i.listenPointerUp(event);
        return true;
      }
    }
    return false;
  }

  @override
  bool handlerPointerMove(PointerMoveEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      final isCover = _isPointerCover(event, i);
      if (isCover) {
        i.listenPointerMove(event);
        return true;
      }
    }
    return false;
  }

  @override
  bool handlerPointerCancel(PointerCancelEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      final isCover = _isPointerCover(event, i);
      if (isCover) {
        i.listenPointerCancel(event);
        return true;
      }
    }
    return false;
  }

  @override
  bool handlerPointerHover(PointerHoverEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      final isCover = _isPointerCover(event, i);
      if (isCover) {
        i.listenPointerHover(event);
        return true;
      }
    }
    return false;
  }

  @override
  bool hasGesture() => true;

  @override
  bool get isVisible => true;
}
