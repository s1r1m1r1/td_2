// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:bonfire/bonfire.dart' hide GameComponent;
import 'package:bonfire/camera/bonfire_camera.dart';
import 'package:flame/camera.dart';
import 'package:flutter/widgets.dart' hide Viewport;

import 'base_game_dev.dart';
import 'game_core/camera/game_camera.dart';
import 'game_core/camera/game_camera_config.dart';

class GameDev extends BaseGameDev {
  static const INTERVAL_UPDATE_ORDER = 500;
  static const INTERVAL_OPTIMIZE_TREE = 5001;

  final GameBackground? background;

  SceneBuilderStatus sceneBuilderStatus = SceneBuilderStatus();

  final List<PositionComponent> _visibleComponents = List.empty(growable: true);

  ValueChanged<GameDev>? onReady;

  @override
  GameCamera get camera => super.camera as GameCamera;
  // BonfireCamera get camera => super.camera as GameCamera;

  @override
  set camera(CameraComponent newCameraComponent) {
    throw Exception('Is forbiden updade camera');
  }

  GameDev({
    // required this.map,
    List<Component>? components,
    List<Component>? hudComponents,
    this.background,
    bool debugMode = false,
    this.onReady,
    GameCameraConfig? cameraConfig,
  }) : super(
          camera: GameCamera(
            config: cameraConfig,
            viewport: _getViewPort(cameraConfig),
            backdrop: background,
            hudComponents: [...?hudComponents],
          ),
          world: World(
            children: [
              // map,
              ...?components,
            ],
          ),
        ) {
    this.debugMode = debugMode;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    if (camera.config.target != null) {
      camera.follow(
        camera.config.target!,
        snap: true,
      );
    }
  }

  bool _gameMounted = false;
  @override
  void update(double dt) {
    super.update(dt);
    final containsChildren = camera.world?.children.isNotEmpty ?? false;
    if (!_gameMounted && containsChildren) {
      _gameMounted = true;
    }
  }

  Iterable<T> visibles<T extends PositionComponent>() {
    return _visibleComponents.whereType<T>();
  }

  Iterable<T> query<T extends Component>({bool onlyVisible = false}) {
    if (onlyVisible) {
      return _visibleComponents.whereType<T>();
    }
    return world.children.query<T>();
  }

  bool isVisibleInCamera(PositionComponent c) {
    if (!hasLayout) {
      return false;
    }
    if (c.isRemoving) {
      return false;
    }
    return camera.canSee(c);
  }

  @override
  FutureOr<void> add(Component component) {
    if (component is CameraComponent || component is World) {
      super.add(component);
    } else {
      return world.add(component);
    }
  }

  @override
  Future<void> addAll(Iterable<Component> components) {
    return world.addAll(components);
  }

  Iterable<T> queryHud<T extends Component>() {
    return camera.viewport.children.query<T>();
  }

  FutureOr<void> addHud(Component component) {
    return camera.viewport.add(component);
  }

  static Viewport? _getViewPort(GameCameraConfig? cameraConfig) {
    if (cameraConfig?.resolution != null) {
      return FixedResolutionViewport(
        resolution: cameraConfig!.resolution!,
      );
    }
    return null;
  }
}
