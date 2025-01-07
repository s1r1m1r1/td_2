// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:bonfire/bonfire.dart' hide GameComponent;
import 'package:bonfire/camera/bonfire_camera.dart';
import 'package:flame/camera.dart';
// ignore: implementation_imports
import 'package:flutter/widgets.dart' hide Viewport;

import 'base_game_dev.dart';

/// Is a customGame where all magic of the Bonfire happen.
class BonfireGameDev extends BaseGameDev {
  static const INTERVAL_UPDATE_ORDER = 500;
  static const INTERVAL_OPTIMIZE_TREE = 5001;

  final GameBackground? background;

  /// Used to draw area collision in objects.

  /// Color of the collision area when `showCollisionArea` is true

  SceneBuilderStatus sceneBuilderStatus = SceneBuilderStatus();

  final List<PositionComponent> _visibleComponents = List.empty(growable: true);
  late IntervalTick _intervalUpdateOder;
  late IntervalTick _intervalOprimizeTree;

  ValueChanged<BonfireGameDev>? onReady;

  @override
  Color backgroundColor() => _bgColor ?? super.backgroundColor();

  Color? _bgColor;

  bool _shouldUpdatePriority = false;

  @override
  BonfireCamera get camera => super.camera as BonfireCamera;

  @override
  set camera(CameraComponent newCameraComponent) {
    throw Exception('Is forbiden updade camera');
  }

  /// variable that keeps the highest rendering priority per frame.
  ///  This is used to determine the order in which to render the `interface`,
  ///  `lighting` and `joystick`
  int _highestPriority = 1000000;

  /// Get of the _highestPriority
  @override
  int get highestPriority => _highestPriority;

  BonfireGameDev({
    // required this.map,
    List<Component>? components,
    List<Component>? hudComponents,
    this.background,
    bool debugMode = false,
    this.onReady,
    Color? backgroundColor,
    CameraConfig? cameraConfig,
  }) : super(
          camera: BonfireCamera(
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
    _intervalOprimizeTree = IntervalTick(
      INTERVAL_OPTIMIZE_TREE,
      onTick: _optimizeCollisionTree,
    );
  }

  @override
  FutureOr<void> onLoad() async {
    initializeCollisionDetection(
      mapDimensions: size.toRect(),
    );
    await super.onLoad();
    // camera.viewport.children.query<PlayerController>().forEach((element) {
    //   if (!element.containObservers) {
    //     // element.addObserver(
    //     //   player ?? JoystickMapExplorer(camera),
    //     // );
    //   }
    // });

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
    _intervalOprimizeTree.update(dt);
    final containsChildren = camera.world?.children.isNotEmpty == true;
    if (!_gameMounted && containsChildren) {
      _gameMounted = true;
    }
  }

  @override
  Iterable<T> visibles<T extends PositionComponent>() {
    return _visibleComponents.whereType<T>();
  }

  @override
  Iterable<T> query<T extends Component>({bool onlyVisible = false}) {
    if (onlyVisible) {
      return _visibleComponents.whereType<T>();
    }
    return world.children.query<T>();
  }

  @override
  Vector2 worldToScreen(Vector2 position) {
    final worldPosition = camera.worldToScreen(position);
    return viewportPositionToGlobal(
      worldPosition,
    );
  }

  @override
  Vector2 screenToWorld(Vector2 position) {
    final viewportPosition = globalToViewportPosition(
      position,
    );
    return camera.screenToWorld(viewportPosition);
  }

  @override
  Vector2 globalToViewportPosition(Vector2 position) {
    return camera.viewport.globalToLocal(position);
  }

  @override
  Vector2 viewportPositionToGlobal(Vector2 position) {
    return camera.viewport.localToGlobal(position);
  }

  @override
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
    _highestPriority = world.children.last.priority;
  }

  @override
  List<RaycastResult<ShapeHitbox>> raycastAll(
    Vector2 origin, {
    required int numberOfRays,
    double startAngle = 0,
    double sweepAngle = tau,
    double? maxDistance,
    List<Ray2>? rays,
    List<ShapeHitbox>? ignoreHitboxes,
    List<RaycastResult<ShapeHitbox>>? out,
  }) {
    return collisionDetection.raycastAll(
      origin,
      numberOfRays: numberOfRays,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      maxDistance: maxDistance,
      rays: rays,
      ignoreHitboxes: ignoreHitboxes,
      out: out,
    );
  }

  @override
  RaycastResult<ShapeHitbox>? raycast(
    Ray2 ray, {
    double? maxDistance,
    List<ShapeHitbox>? ignoreHitboxes,
    RaycastResult<ShapeHitbox>? out,
  }) {
    return collisionDetection.raycast(
      ray,
      maxDistance: maxDistance,
      ignoreHitboxes: ignoreHitboxes,
      out: out,
    );
  }

  @override
  Iterable<RaycastResult<ShapeHitbox>> raytrace(
    Ray2 ray, {
    int maxDepth = 10,
    List<ShapeHitbox>? ignoreHitboxes,
    List<RaycastResult<ShapeHitbox>>? out,
  }) {
    return collisionDetection.raytrace(
      ray,
      maxDepth: maxDepth,
      ignoreHitboxes: ignoreHitboxes,
      out: out,
    );
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

  void _optimizeCollisionTree() {
    scheduleMicrotask(collisionDetection.broadphase.tree.optimize);
  }

  void _updateOrderPriorityMicrotask() {
    if (_shouldUpdatePriority) {
      _shouldUpdatePriority = false;
      scheduleMicrotask(_updateOrderPriority);
    }
  }

  // @override
  // Vector2 get worldsize => map.size;

  @override
  Iterable<T> queryHud<T extends Component>() {
    return camera.viewport.children.query<T>();
  }

  @override
  FutureOr<void> addHud(Component component) {
    return camera.viewport.add(component);
  }

  static Viewport? _getViewPort(CameraConfig? cameraConfig) {
    if (cameraConfig?.resolution != null) {
      return FixedResolutionViewport(
        resolution: cameraConfig!.resolution!,
      );
    }
    return null;
  }
}
