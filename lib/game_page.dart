import 'package:flame/components.dart' show Vector2;
import 'package:flame/game.dart' show GameWidget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/audio/audio_cubit.dart';
import 'bloc/stage_bloc.dart';
import 'bloc/stage_stats_bloc.dart';
import 'bloc/stage_treasury_bloc.dart';
import 'bloc/weapon_bar_bloc.dart';
import 'domain/weapon_option.dart';
import 'game_module/controller/game_controller.dart';
import 'game_module/controller/game_event.dart';
import 'game_module/core/process_game.dart';
import 'game_module/hud/hud_floor_type.dart';
import 'game_module/hud/hud_left.dart';
import 'game_module/hud/hud_weapons_bar.dart';
import 'game_module/other/offset_ext.dart';

class GamePage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GamePage._(),
    );
  }

  const GamePage._();

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
        BlocProvider(
          create: (_) =>
              GetIt.I.get<WeaponBarBloc>()..add(const WeaponBarEvent.read()),
        ),
      ],
      child: const Center(child: GameView()),
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
      body: BlocBuilder<WeaponBarBloc, WeaponBarState>(
        builder: (context, weaponBarState) {
          switch (weaponBarState) {
            case $InitWeaponBarState():
            case $ProcessingWeaponBarState():
              return _loading('loading weapon bar ...');
            case $SuccessWeaponBarState():
              return BlocBuilder<StageBloc, StageState>(
                builder: (context, stageState) {
                  switch (stageState) {
                    case $InitStageState():
                    case $ProcessingStageState():
                      return _loading('loading stage ...');
                    case $SuccessStageState():
                      return LoadedGameView(
                        stageState: stageState,
                        weaponBarState: weaponBarState,
                      );
                  }
                },
              );
          }
        },
      ),
    );
  }

  Widget _loading(String message) {
    return Center(
      child: Text(message),
    );
  }
}

class LoadedGameView extends StatelessWidget {
  const LoadedGameView({
    super.key,
    required this.stageState,
    required this.weaponBarState,
  });
  final $SuccessStageState stageState;
  final $SuccessWeaponBarState weaponBarState;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GameWidget(
          game: ProcessGame(
            stage: stageState.result,
            stageStatsBloc: GetIt.I.get<StageStatsBloc>(),
            stageTreasuryBloc: GetIt.I.get<StageTreasuryBloc>(),
            components: [],
            hudComponents: [
              HudLeft(position: Vector2(0, 0), size: Vector2.all(140)),
              HudWeaponItem(position: Vector2(300, 100), size: Vector2.all(100)),
              HudLeft(
                position: Vector2(32, size.height - 200),
                size: Vector2.all(60),
              ),
              HudCurrentFloor(
                position: Vector2(size.width - 200, size.height - 200),
              ),
            ],
            audioPlayer: context.read<AudioCubit>().effectPlayer,
            weapons: weaponBarState.result,
          ),
        ),
      ],
    );
  }
}

// class LoadedGameView extends StatelessWidget {
//   const LoadedGameView({
//     super.key,
//     required this.stageState,
//     required this.weaponBarState,
//   });
//   final $SuccessStageState stageState;
//   final $SuccessWeaponBarState weaponBarState;

//   @override
//   Widget build(BuildContext context) {
//     debugPrint('MEDIA Query ${MediaQuery.of(context).size}');
//     const margin = EdgeInsetsDirectional.only(top: 100);
//     final moveCamera = MoveCameraController()..setMargin(margin);
//     return Stack(
//       children: [
//         Padding(
//           padding: margin,
//           child: GameWidgetDev(
//             hudComponents: [
//               TowersInterface(moveCamera),
//               moveCamera,
//               GameController(
//                   stageStatsBloc: GetIt.I.get<StageStatsBloc>(),
//                   stageTreasuryBloc: GetIt.I.get<StageTreasuryBloc>(),
//                   stage: stageState.result,
//                   weapons: weaponBarState.result),
//             ],
//             components: [
//               World(),
//             ],
//           ),
//         ),
//         const _DragTargetZone(margin: margin),
//         _PositionedWeaponBar(
//           height: margin.top,
//           weaponBarState: weaponBarState,
//         ),
//       ],
//     );
//   }
// }

class _DragTargetZone extends StatelessWidget {
  const _DragTargetZone({
    required this.margin,
  });

  final EdgeInsetsDirectional margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: DragTarget(
        onMove: (details) {
          final double dx = details.offset.dx + 50 + 0;
          final double dy = details.offset.dy - 50.0;

          final center = Offset(dx, dy);
          // GameController.event(GameEvent.movePointerGlobal(center.toVector2()));
        },
        onAcceptWithDetails: (details) {
          final double dx = details.offset.dx + 50 + 0;
          final double dy = details.offset.dy - 50.0;
          final center = Offset(dx, dy);
          final weaponId = details.data;
          if (weaponId is! WeaponId) return;
          // GameController.event( GameEvent.finishPointerGlobal(center.toVector2(), weaponId));
        },
        builder: (_, __, ___) => const SizedBox.expand(),
      ),
    );
  }
}

class _PositionedWeaponBar extends StatelessWidget {
  const _PositionedWeaponBar({
    required this.height,
    required this.weaponBarState,
  });

  final double height;
  final $SuccessWeaponBarState weaponBarState;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...weaponBarState.result.map(
            (i) => Draggable<WeaponId>(
              // Data is the value this Draggable stores.
              data: i.id,
              feedback: SizedBox.square(
                dimension: 50,
                child: Image(
                  image: i.barImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
              childWhenDragging: SizedBox.square(
                dimension: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  // Image with stroke effect
                  child: Image(
                    image: i.barImage,
                    fit: BoxFit.fitHeight,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      final colored = ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              Colors.purple, BlendMode.srcIn),
                          child: child);
                      // stroke
                      const s = 2.0;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ...List.generate(8, (i) {
                            final padding = switch (i) {
                              0 => const EdgeInsets.fromLTRB(s, s, 0, 0),
                              1 => const EdgeInsets.fromLTRB(0, s, s, 0),
                              2 => const EdgeInsets.fromLTRB(0, 0, s, s),
                              3 => const EdgeInsets.fromLTRB(s, 0, 0, s),
                              4 => const EdgeInsets.fromLTRB(s, 0, 0, 0),
                              5 => const EdgeInsets.fromLTRB(0, s, 0, 0),
                              6 => const EdgeInsets.fromLTRB(0, 0, s, 0),
                              7 => const EdgeInsets.fromLTRB(0, 0, 0, s),
                              _ => EdgeInsets.zero
                            };
                            debugPrint('repaint Stack item');
                            return Padding(
                              padding: padding,
                              child: colored,
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.all(s),
                            child: SizedBox(child: child),
                          ),
                        ],
                      );
                    },
                    // color: Colors.grey,
                    // colorBlendMode: BlendMode.saturation,
                  ),
                ),
              ),
              child: SizedBox.square(
                dimension: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                  child: Image(
                    image: i.barImage,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
