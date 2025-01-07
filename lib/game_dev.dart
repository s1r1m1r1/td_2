// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:bonfire/bonfire.dart' hide GameComponent;
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
  late IntervalTick _intervalUpdateOder;

  ValueChanged<GameDev>? onReady;

  @override
  Color backgroundColor() => _bgColor ?? super.backgroundColor();

  Color? _bgColor;

  bool _shouldUpdatePriority = false;

  @override
  GameCamera get camera => super.camera as GameCamera;

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
    Color? backgroundColor,
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
    _bgColor = backgroundColor;

    _intervalUpdateOder = IntervalTick(
      INTERVAL_UPDATE_ORDER,
      onTick: _updateOrderPriorityMicrotask,
    );
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
    _intervalUpdateOder.update(dt);
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

  Vector2 worldToScreen(Vector2 position) {
    final worldPosition = camera.worldToScreen(position);
    return viewportPositionToGlobal(
      worldPosition,
    );
  }

  Vector2 screenToWorld(Vector2 position) {
    final viewportPosition = globalToViewportPosition(
      position,
    );
    return camera.screenToWorld(viewportPosition);
  }

  Vector2 globalToViewportPosition(Vector2 position) {
    return camera.viewport.globalToLocal(position);
  }

  Vector2 viewportPositionToGlobal(Vector2 position) {
    return camera.viewport.localToGlobal(position);
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
  void startScene(List<SceneAction> actions, {void Function()? onComplete}) {
    if (!sceneBuilderStatus.isRunning) {
      add(SceneBuilderComponent(actions, onComplete: onComplete));
    }
  }

  @override
  void stopScene() {
    world.children
        .whereType<SceneBuilderComponent>()
        .firstOrNull
        ?.removeFromParent();
  }

  void addVisible(PositionComponent obj) {
    _visibleComponents.add(obj);
  }

  void removeVisible(PositionComponent obj) {
    _visibleComponents.remove(obj);
  }

  @override
  void enableGestures(bool enable) {
    enabledGestures = enable;
  }

  void requestUpdatePriority() {
    _shouldUpdatePriority = true;
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

  /// reorder components by priority
  void _updateOrderPriority() {
    // ignore: invalid_use_of_internal_member
    world.children.reorder();
  }

  /// Used to generate numbers to create your animations or anythings
  @override
  ValueGeneratorComponent generateValues(
    Duration duration, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.linear,
    Curve? reverseCurve,
    bool autoStart = true,
    bool infinite = false,
    VoidCallback? onFinish,
    ValueChanged<double>? onChange,
  }) {
    final valueGenerator = ValueGeneratorComponent(
      duration,
      end: end,
      begin: begin,
      curve: curve,
      reverseCurve: reverseCurve,
      onFinish: onFinish,
      onChange: onChange,
      autoStart: autoStart,
      infinite: infinite,
    );
    add(valueGenerator);
    return valueGenerator;
  }

  void _updateOrderPriorityMicrotask() {
    if (_shouldUpdatePriority) {
      _shouldUpdatePriority = false;
      scheduleMicrotask(_updateOrderPriority);
    }
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
