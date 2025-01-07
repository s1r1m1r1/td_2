import 'package:bonfire/background/game_background.dart';
import 'package:bonfire/base/listener_game_widget.dart';
import 'package:bonfire/camera/camera_config.dart';
import 'package:bonfire/color_filter/game_color_filter.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'game_dev.dart';

class BonfireWidgetDev extends StatefulWidget {
  final bool debugMode;
  final Color? backgroundColor;
  final ValueChanged<BonfireGameDev>? onReady;
  final Map<String, OverlayWidgetBuilder<BonfireGameDev>>? overlayBuilderMap;
  final List<String>? initialActiveOverlays;
  final List<Component>? components;
  final List<Component>? hudComponents;
  final GameBackground? background;
  final CameraConfig? cameraConfig;
  final GameColorFilter? colorFilter;

  const BonfireWidgetDev({
    // required this.map,
    super.key,
    this.background,
    this.debugMode = false,
    this.backgroundColor,
    this.colorFilter,
    this.hudComponents,
    this.components,
    this.overlayBuilderMap,
    this.initialActiveOverlays,
    this.cameraConfig,
    this.onReady,
  });

  @override
  BonfireWidgetState createState() => BonfireWidgetState();
}

class BonfireWidgetState extends State<BonfireWidgetDev> {
  @override
  Widget build(BuildContext context) {
    return ListenerGameWidget(
      game: BonfireGameDev(
        components: widget.components,
        hudComponents: widget.hudComponents,
        background: widget.background,
        backgroundColor: widget.backgroundColor,
        debugMode: widget.debugMode,
        cameraConfig: widget.cameraConfig,
        onReady: widget.onReady,
      ),
      overlayBuilderMap: widget.overlayBuilderMap,
      initialActiveOverlays: widget.initialActiveOverlays,
    );
  }
}
