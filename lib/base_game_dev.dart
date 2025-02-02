// // import 'package:bonfire/bonfire.dart';
// import 'package:bonfire/mixins/pointer_detector.dart';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/gestures.dart';

// abstract class BaseGameDev extends FlameGame
//     with PointerDetector,  HasTimeScale {
//   BaseGameDev({super.world, super.camera});
//   bool enabledGestures = true;
//   bool enabledKeyboard = true;
//   Iterable<PointerDetectorHandler> _gesturesComponents = [];

//   @override
//   void updateTree(double dt) {
//     // todo can improve this ??
//     _gesturesComponents = [...world.children, ...camera.viewport.children]
//         .whereType<PointerDetectorHandler>();
//     super.updateTree(dt);
//   }

//   @override
//   void onPointerCancel(PointerCancelEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerCancel(event)) {
//         return;
//       }
//     }
//   }

//   @override
//   void onPointerUp(PointerUpEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerUp(event)) {
//         return;
//       }
//     }
//   }

//   @override
//   void onPointerMove(PointerMoveEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerMove(event)) {
//         return;
//       }
//     }
//   }

//   @override
//   void onPointerDown(PointerDownEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerDown(event)) {
//         return;
//       }
//     }
//   }

//   @override
//   void onPointerHover(PointerHoverEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerHover(event)) {
//         return;
//       }
//     }
//   }

//   @override
//   void onPointerSignal(PointerSignalEvent event) {
//     if (!hasLayout || !enabledGestures) {
//       return;
//     }
//     for (final c in _gesturesComponents) {
//       if (c.handlerPointerSignal(event)) {
//         return;
//       }
//     }
//   }

    

//   @override
//   void onRemove() {
//     super.onRemove();
//     removeAll(children);
//     processLifecycleEvents();
//   }
// }
