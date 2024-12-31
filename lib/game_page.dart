import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/base/layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:td_2/bloc/stage_treasury_bloc.dart';
import 'package:td_2/game_core/controller/game_event.dart';
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
    final posNtf = ValueNotifier(Offset.zero);
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
              const margin = EdgeInsetsDirectional.only(top: 100);
              final moveCamera = MoveCameraController()..setMargin(margin);
              return Stack(
                children: [
                  Padding(
                    padding: margin,
                    child: BonfireWidget(
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
                        // ...StageMap.enemies(),
                        // ...StageMap.decorations(),

                        moveCamera,
                        GameController(
                          stageStatsBloc: GetIt.I.get<StageStatsBloc>(),
                          stageTreasuryBloc: GetIt.I.get<StageTreasuryBloc>(),
                          stage: state.result,
                        ),
                      ],
                      cameraConfig: CameraConfig(
                        zoom: getZoomFromMaxVisibleTile(
                            context, StageMap.tileSize, 20),
                      ),
                      interface: TowersInterface(moveCamera),
                      map: WorldMap([
                        Layer(id: 0, tiles: [
                          ...state.result.layer.tiles.map((i) => Tile(
                              x: i.x.toDouble(),
                              y: i.y.toDouble(),
                              width: StageMap.tileSize,
                              height: StageMap.tileSize,
                              sprite: TileSprite(path: i.assetPath)))
                        ])
                      ]),
                      backgroundColor: Colors.blueGrey[900]!,
                      lightingColorGame: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  Padding(
                    padding: margin,
                    child: DragTarget(onMove: (details) {
                      double dx = details.offset.dx + 50 + 0;
                      double dy = details.offset.dy - 50.0;

                      final center = Offset(dx, dy);
                      GameController.event(
                          GameEvent.movePointerGlobal(center.toVector2()));
                    }, onAcceptWithDetails: (details) {
                      double dx = details.offset.dx + 50 + 0;
                      double dy = details.offset.dy - 50.0;

                      final center = Offset(dx, dy);
                      GameController.event(
                          GameEvent.finishPointerGlobal(center.toVector2()));
                    }, builder: (context, candidateData, rejectedData) {
                      return const SizedBox.expand();
                    }),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: margin.top,
                      child: Row(
                        children: [
                          Draggable<int>(
                            // Data is the value this Draggable stores.
                            data: 10,
                            feedback: Container(
                              color: Colors.deepOrange.withAlpha(50),
                              height: 100,
                              width: 100,
                              child: const Icon(Icons.directions_run),
                            ),
                            childWhenDragging: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.pinkAccent,
                              child: const Center(
                                child: Text('Child When Dragging'),
                              ),
                            ),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.lightGreenAccent,
                              child: const Center(
                                child: Text('Draggable'),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              );
          }
        },
      ),
    );
  }
}
