import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart' show ValueNotifier, debugPrint;

import '../camera/game_camera.dart';
import '../camera/game_camera_config.dart';
import '../controller/game_event.dart';
import 'mixin_game_size.dart';

class BaseGame extends FlameGame
    with TapDetector, PanDetector, ScrollDetector, MixinGameSize {
  final Component? background;
  BaseGame({
    List<Component>? components,
    List<Component>? hudComponents,
    this.background,
    bool debugMode = false,
    GameCameraConfig? cameraConfig,
  }) : super(
            camera: GameCamera(
              config: cameraConfig,
              viewport: _getViewPort(cameraConfig),
              backdrop: background,
              hudComponents: [...?hudComponents],
            ),
            world: World(children: [...?components]));

  final enableHudNotifier = ValueNotifier<bool>(true);

//------------------------------------
  final instructQ = <GameEvent>[];
  void addEvent(GameEvent event) {
    instructQ.add(event);
  }

//------------------------------------

  @override
  GameCamera get camera => super.camera as GameCamera;

  final _panIgnores = <PositionComponent>[];
  void addPanIgnore(PositionComponent c) {
    _panIgnores.add(c);
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    if (camera.config.target != null) {
      camera.follow(camera.config.target!, snap: true);
    }
    images.prefix = '';
  }

  @override
  void onRemove() {
    super.onRemove();
    removeAll(children);
    _panIgnores.clear();
    processLifecycleEvents();
  }

  @override
  void onTapUp(TapUpInfo info) {
    // print('ON TAPUP GAME');
    final worldPos = camera.globalToLocal(info.eventPosition.global);
    // checkDialog
    addEvent(GameEvent.onTapUp(worldPos));

    super.onTapUp(info);
  }

  @override
  void onTapDown(TapDownInfo info) {
    // print('ON TAPdown GAME');
    super.onTapDown(info);
  }

  @override
  void onPanUpdate(info) {
    if (enableHudNotifier.value) {
      final global = info.eventPosition.global.toOffset();
      final overHud = _panIgnores.any(
        (p) => Rect.fromPoints(p.absolutePosition.toOffset(),
                (p.absolutePosition + p.size).toOffset())
            .contains(global),
      );
      if (overHud) return;
      final worldPos = camera.globalToLocal(info.eventPosition.global);
      camera.moveTo(
        camera.viewfinder.position.translated(
          -info.delta.global.x * 5,
          -info.delta.global.y * 5,
        ),
      );
      addEvent(GameEvent.onDragUpdate(worldPos));
    }
  }

  // @override
  // void onTapCancel(int pointerId) {
  //   // debugPrint('TAP CANCEL');
  //   super.onTapCancel(pointerId);
  // }

  static Viewport? _getViewPort(GameCameraConfig? cameraConfig) {
    if (cameraConfig?.resolution != null) {
      return FixedResolutionViewport(resolution: cameraConfig!.resolution!);
    }
    return null;
  }
}
