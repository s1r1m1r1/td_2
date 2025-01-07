import 'dart:ui';

// import 'package:bonfire/bonfire.dart';

// import 'package:bonfire/camera/camera_effects.dart';
import 'package:bonfire/camera/camera_effects.dart'
    show MyFollowBehavior, ShakeEffect;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../../game_dev.dart';
import '../other/math_ext.dart';
import 'game_camera_config.dart';

class GameCamera extends CameraComponent with HasGameReference<GameDev> {
  double _spacingMap = 32.0;
  final GameCameraConfig config;
  GameCamera({
    GameCameraConfig? config,
    super.world,
    super.hudComponents,
    super.viewport,
    super.backdrop,
  }) : config = config ?? GameCameraConfig() {
    if (this.config.initPosition != null) {
      viewfinder.position = this.config.initPosition!;
    }
    viewfinder.zoom = this.config.zoom;
    viewfinder.angle = this.config.angle;
    if (this.config.target != null) {
      follow(this.config.target!, snap: true);
    }
  }

  Rect get cameraRectWithSpacing =>
      visibleWorldRect.inflate(_spacingMap / viewfinder.zoom);
  // ---------

  Vector2 get visibleSize => visibleWorldRect.sizeVector2;

  Vector2 get topleft => visibleWorldRect.positionVector2;

  bool canSeeWithMargin(PositionComponent component) {
    return cameraRectWithSpacing.overlaps(component.toAbsoluteRect());
  }

  // ignore: use_setters_to_change_properties
  void updateSpacingVisibleMap(double space) {
    _spacingMap = space;
  }

  void moveToPositionAnimated({
    required Vector2 position,
    EffectController? effectController,
    double? zoom,
    double? angle,
    Function()? onComplete,
  }) {
    stop();
    final controller = effectController ?? EffectController(duration: 1);
    final moveToEffect = MoveToEffect(
      position,
      controller,
      onComplete: onComplete,
    );

    viewfinder.add(moveToEffect);
    if (zoom != null) {
      final zoomEffect = ScaleEffect.to(
        Vector2.all(zoom),
        controller,
      );
      zoomEffect.removeOnFinish = true;
      viewfinder.add(zoomEffect);
    }
    if (angle != null) {
      final rotateEffect = RotateEffect.to(
        angle,
        controller,
      );
      rotateEffect.removeOnFinish = true;
      viewfinder.add(rotateEffect);
    }
  }

  void moveToTargetAnimated({
    required PositionComponent target,
    EffectController? effectController,
    double? zoom,
    double? angle,
    Function()? onComplete,
    bool followTarget = true,
  }) {
    moveToPositionAnimated(
      position: target.position,
      effectController: effectController,
      zoom: zoom,
      angle: angle,
      onComplete: () {
        if (followTarget) {
          follow(target);
        }
        onComplete?.call();
      },
    );
  }

  @override
  void follow(
    ReadOnlyPositionProvider target, {
    double maxSpeed = double.infinity,
    bool horizontalOnly = false,
    bool verticalOnly = false,
    bool snap = false,
  }) {
    stop();
    viewfinder.add(
      MyFollowBehavior(
        target: target,
        targetSize: _getTargetSize(target),
        maxSpeed: config.speed,
        movementWindow: config.movementWindow,
        horizontalOnly: horizontalOnly,
        verticalOnly: verticalOnly,
      ),
    );
    if (snap) {
      viewfinder.position = target.position;
    }
  }

  void animateZoom({
    required Vector2 zoom,
    EffectController? effectController,
    Function()? onComplete,
  }) {
    final zoomEffect = ScaleEffect.to(
      zoom,
      effectController ?? EffectController(duration: 1),
      onComplete: onComplete,
    );
    zoomEffect.removeOnFinish = true;
    viewfinder.add(zoomEffect);
  }

  void animateAngle({
    required double angle,
    EffectController? effectController,
    Function()? onComplete,
  }) {
    final rotateEffect = RotateEffect.to(
      angle,
      effectController ?? EffectController(duration: 1),
      onComplete: onComplete,
    );
    rotateEffect.removeOnFinish = true;
    viewfinder.add(rotateEffect);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // updateBoundsAndZoomFit();
  }

  // void updateBoundsAndZoomFit({
  //   bool? moveOnlyMapArea,
  //   InitialMapZoomFitEnum? mapZoomFit,
  // }) {
  //   this.mapZoomFit = mapZoomFit ?? config.initialMapZoomFit;
  //   this.moveOnlyMapArea = moveOnlyMapArea ?? config.moveOnlyMapArea;
  // }

  // set mapZoomFit(InitialMapZoomFitEnum value) {
  //   config.initialMapZoomFit = value;
  //   final sizeScreen = canvasSize;
  //   switch (value) {
  //     case InitialMapZoomFitEnum.none:
  //       break;
  //     case InitialMapZoomFitEnum.fitWidth:
  //       zoom = sizeScreen.x / game.world.map.getMapSize().x;
  //       break;
  //     case InitialMapZoomFitEnum.fitHeight:
  //       zoom = sizeScreen.y / game.map.getMapSize().y;
  //       break;
  //     case InitialMapZoomFitEnum.fit:
  //       if (sizeScreen.x > sizeScreen.y) {
  //         zoom = sizeScreen.x / game.map.getMapSize().x;
  //       } else {
  //         zoom = sizeScreen.y / game.map.getMapSize().y;
  //       }
  //       break;
  //   }
  // }

  Vector2 get canvasSize => viewport.size;

  // set moveOnlyMapArea(bool enabled) {
  //   if (!viewfinder.isMounted) {
  //     return;
  //   }
  //   config.moveOnlyMapArea = enabled;
  //   if (enabled) {
  //     setBounds(
  //       Rectangle.fromRect(
  //         game.map.getMapRect().deflatexy(
  //               visibleWorldRect.width / 2,
  //               visibleWorldRect.height / 2,
  //             ),
  //       ),
  //     );
  //   } else {
  //     setBounds(null);
  //   }
  // }

  Vector2 worldToScreen(Vector2 worldPosition) {
    return (worldPosition - topleft) * viewfinder.zoom;
  }

  Vector2 screenToWorld(Vector2 position) {
    return topleft + (position / viewfinder.zoom);
  }

  void shake({double intensity = 10.0, Duration? duration}) {
    viewfinder.add(
      ShakeEffect(
        intensity: intensity,
        duration: duration ?? const Duration(milliseconds: 300),
      ),
    );
  }

  Vector2? _getTargetSize(ReadOnlyPositionProvider target) {
    if (target is PositionComponent) {
      if (target.anchor == Anchor.topLeft) {
        return target.size;
      }
      if (target.anchor == Anchor.bottomRight) {
        return -target.size;
      }
    }
    return null;
  }
}
