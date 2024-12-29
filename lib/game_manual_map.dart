import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controllers/grid_component.dart';
import 'stage_map.dart';
import 'controllers/game_manual_controller.dart';
import 'ui/towers_interface.dart';

class GameManualMap extends StatelessWidget {
  const GameManualMap({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BonfireWidget(
        playerControllers: [
          Joystick(
            actions: [
              // JoystickAction(
              //   actionId: 'gun',
              //   sprite: Sprite.load('joystick_attack.png'),
              //   size: 80,
              //   margin: const EdgeInsets.only(bottom: 50, right: 50),
              // ),
              // JoystickAction(
              //   actionId: 'next',
              //   sprite: Sprite.load('joystick_attack_range.png'),
              //   spriteBackgroundDirection:
              //       Sprite.load('joystick_background.png'),
              //   size: 50,
              //   enableDirection: true,
              //   margin: const EdgeInsets.only(bottom: 50, right: 160),
              // )
            ],
          ),
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
          GridComponent()
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