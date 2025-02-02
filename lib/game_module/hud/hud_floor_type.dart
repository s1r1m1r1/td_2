import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../tile/floor_component.dart';
import '../tile/floor_type.dart';

class H extends AdvancedButtonComponent {}

class HudCurrentFloor extends PositionComponent
    with HoverCallbacks, TapCallbacks {
  HudCurrentFloor({
    // this.onPressed,
    // this.onReleased,
    super.size,
    super.position,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  }) {
    size.addListener(_updateSizes);
  }



  final skinContainer = Component();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(skinContainer);
  }

  bool isPressed = false;

  void onTapDown(TapDownEvent event) {
    // if (_isDisabled) {
    //   return;
    // }
    // onPressed?.call();
    // isPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    // if (_isDisabled) {
    //   return;
    // }
    // isPressed = false;
    // onReleased?.call();
  }

  @override
  void onHoverEnter() {}

  @override
  void onHoverExit() {
    isPressed = false;
  }

  Map<FloorType, PositionComponent?> skinsMap = {};

  void setSkinType(FloorType type, PositionComponent skin) {
    // debugPrint("SKINCMP type ${type} skin: $skin ${skinsMap.length}");
    skinsMap[type] = skin;
  }

  void changeSkin(FloorType type) {
    _removeSkins();
    _setSkin(type);
  }

  void _updateSizes() {
    for (final skin in skinsMap.values) {
      skin?.size = size;
    }
  }

  void _setSkin(FloorType type) {
    var skinComponent = skinsMap[type];
    if (skinComponent == null) return;
    skinComponent.parent = skinContainer;
  }

  void _removeSkins() {
    for (final skins in skinsMap.values) {
      skins?.parent = null;
    }
  }

  bool hasSkinForState(FloorType type) {
    return skinsMap[type] != null;
  }
}
