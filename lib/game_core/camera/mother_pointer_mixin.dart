import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/pointer_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin MotherPointerListener on PositionComponent  {
  bool enableDrag = true;
  bool isDragging = false;

  void listenPointerDown(PointerDownEvent event) {}

  void listenPointerMove(PointerMoveEvent event) {}

  void listenPointerUp(PointerUpEvent event) {}

  void listenPointerCancel(PointerCancelEvent event) {}

  void listenPointerHover(PointerHoverEvent event) {}
}

mixin MotherPointerMixin on Component, PointerDetectorHandler {
  final _listener = <MotherPointerListener>[];

  void addListener(MotherPointerListener listener) {
    _listener.add(listener);
  }

  void removeListener(MotherPointerListener listener) {
    _listener.remove(listener);
  }

  void setMargin(EdgeInsetsDirectional value) {
    _margin = value;
  }

  EdgeInsetsDirectional _margin = EdgeInsetsDirectional.zero;
  Vector2 get marginVec2 => Vector2(_margin.start, _margin.top);

  @override
  void remove(Component component) {
    _listener.clear();
    super.remove(component);
  }

  bool _isPointerCover(PointerEvent event, PositionComponent c) {
    final screenPos = c.absolutePosition + marginVec2;
    final rect = Rect.fromLTWH(screenPos.x, screenPos.y, c.size.x, c.size.y);
    return rect.contains(event.position);
  }

  @override
  bool handlerPointerDown(PointerDownEvent event) {
    for (final i in _listener) {
      if (!i.enableDrag) continue;
      if (!i.isDragging) {
        final isCover = _isPointerCover(event, i);
        if (!isCover) continue;
      }
      i.listenPointerDown(event);
      return true;
    }
    return false;
  }

  @override
  bool handlerPointerUp(PointerUpEvent event) {
    for (var i in _listener) {
      if (!i.enableDrag) continue;
      if (!i.isDragging) {
        final isCover = _isPointerCover(event, i);
        if (!isCover) continue;
      }
      i.listenPointerUp(event);
      return true;
    }
    return false;
  }

  @override
  bool handlerPointerMove(PointerMoveEvent event) {
    for (final i in _listener) {
      if (!i.enableDrag) continue;
      if (!i.isDragging) {
        final isCover = _isPointerCover(event, i);
        if (!isCover) continue;
      }
      i.listenPointerMove(event);
      return true;
    }
    return false;
  }

  @override
  bool handlerPointerCancel(PointerCancelEvent event) {
    for (final i in _listener) {
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
    for (final i in _listener) {
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
