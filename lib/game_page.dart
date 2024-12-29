import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tile/stage_map.dart';
import 'controller/game_manual_controller.dart';
import 'interface/towers_interface.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BonfireWidget(
        playerControllers: [
          Keyboard(
            config: KeyboardConfig(
              acceptedKeys: [
                LogicalKeyboardKey.space,
              ],
            ),
          )
        ],
        components: [
          ...StageMap.enemies(),
          ...StageMap.decorations(),
          GameManualController(),
        ],
        cameraConfig: CameraConfig(
          zoom: getZoomFromMaxVisibleTile(context, StageMap.tileSize, 20),
        ),
        interface: TowersInterface(),
        map: StageMap.map(),
        backgroundColor: Colors.blueGrey[900]!,
        lightingColorGame: Colors.black.withOpacity(0.75),
      );
    });
  }
}
