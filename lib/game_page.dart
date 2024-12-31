import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:td_2/bloc/stage_treasury_bloc.dart';
import 'package:td_2/game_core/controller/move_camera_controller.dart';

import 'bloc/stage_bloc.dart';
import 'bloc/stage_stats_bloc.dart';
import 'game_core/tile/stage_map.dart';
import 'game_core/controller/game_controller.dart';
import 'game_core/ui/towers_interface.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<StageStatsBloc>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<StageTreasuryBloc>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<StageBloc>()..add(const StageEvent.read()),
        ),
      ],
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StageBloc, StageState>(
        builder: (context, state) {
          switch (state) {
            case $InitStageState():
            case $ProcessingStageState():
              return const Center(
                child: Text('loading...'),
              );
            case $SuccessStageState():
              final moveCamera = MoveCameraController();
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
                  moveCamera,
                  GameController(
                    stageStatsBloc: GetIt.I.get<StageStatsBloc>(),
                    stageTreasuryBloc: GetIt.I.get<StageTreasuryBloc>(),
                    stage: state.result,
                  ),
                ],
                cameraConfig: CameraConfig(
                  zoom:
                      getZoomFromMaxVisibleTile(context, StageMap.tileSize, 20),
                ),
                interface: TowersInterface(moveCamera),
                map: StageMap.map(),
                backgroundColor: Colors.blueGrey[900]!,
                lightingColorGame: Colors.black.withOpacity(0.75),
              );
          }
        },
      ),
    );
  }
}
