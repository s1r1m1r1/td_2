// import 'package:bonfire/background/game_background.dart';
// import 'package:bonfire/base/listener_game_widget.dart';
// import 'package:bonfire/color_filter/game_color_filter.dart';
// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';

// import 'game_module/camera/game_camera_config.dart';
// import 'game_dev.dart';

// class GameWidgetDev extends StatelessWidget {
//   final bool debugMode;
//   final ValueChanged<GameDev>? onReady;
//   final Map<String, OverlayWidgetBuilder<GameDev>>? overlayBuilderMap;
//   final List<String>? initialActiveOverlays;
//   final List<Component>? components;
//   final List<Component>? hudComponents;
//   final GameBackground? background;
//   final GameCameraConfig? cameraConfig;
//   final GameColorFilter? colorFilter;

//   const GameWidgetDev({
//     super.key,
//     this.background,
//     this.debugMode = false,
//     this.colorFilter,
//     this.hudComponents,
//     this.components,
//     this.overlayBuilderMap,
//     this.initialActiveOverlays,
//     this.cameraConfig,
//     this.onReady,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListenerGameWidget(
//       game: GameDev(
//         components: components,
//         hudComponents: hudComponents,
//         background: background,
//         debugMode: debugMode,
//         cameraConfig: cameraConfig,
//         onReady: onReady,
//       ),
//       overlayBuilderMap: overlayBuilderMap,
//       initialActiveOverlays: initialActiveOverlays,
//     );
//   }
// }
