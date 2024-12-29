import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'world/grid_component.dart';
import 'world/stage_map.dart';
import 'controller/game_manual_controller.dart';
import 'interface/towers_interface.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

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