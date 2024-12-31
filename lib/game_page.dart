import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:td_2/bloc/stage_treasury_bloc.dart';
import 'package:td_2/game_core/controller/move_camera_controller.dart';

import 'bloc/stage_bloc.dart';
import 'bloc/stage_stats_bloc.dart';
import 'game_core/tile/stage_map.dart';
import 'game_core/controller/game_controller.dart';
import 'game_core/interface/towers_interface.dart';

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
          MoveCameraController(),
          GameController(
            stageStatsBloc: GetIt.I.get<StageStatsBloc>(),
            stageTreasuryBloc: GetIt.I.get<StageTreasuryBloc>(),
            stageBloc: GetIt.I.get<StageBloc>(),
          ),
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
