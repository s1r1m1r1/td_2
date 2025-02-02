import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../domain/enums/enemy_type.dart';
import '../domain/enums/tile_type.dart';
import '../domain/map_option.dart';
import '../domain/stage_option.dart';
import '../domain/wave_option.dart';
import '../game_module/other/stage_map.dart';

part 'stage_bloc.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class StageEvent with _$StageEvent {
  const StageEvent._();

  const factory StageEvent.read() = _ReadStageEvent;
  const factory StageEvent.completed() = _CompletedStageEvent;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
sealed class StageState with _$StageState {
  const StageState._();
  const factory StageState.init() = $InitStageState;
  const factory StageState.processing() = $ProcessingStageState;
  const factory StageState.success(StageOption result) = $SuccessStageState;
}

@lazySingleton
class StageBloc extends Bloc<StageEvent, StageState> {
  StageBloc() : super(const StageState.init()) {
    on<StageEvent>(
      (event, emitter) async {
        switch (event) {
          // case _CreateStageEvent():
          //   await _create(event, emitter);
          // case _ReadStageEvent():
          //   await _read(event, emitter);
          // case _UpdateStageEvent():
          //   await _update(event, emitter);
          // case _DeleteStageEvent():
          //   await _delete(event, emitter);
          case _ReadStageEvent():
            _read(event, emitter);
          case _CompletedStageEvent():
            break;
        }
      },
    );
  }

  Future<void> _read(_ReadStageEvent event, Emitter<StageState> emitter) async {
    emitter(const StageState.processing());
    try {
      final result = StageOption(
        id: 0,
        layer: LayerOption(width: 10, height: 10, tiles: [
          ...List.generate(10, (x) {
            return List.generate(10, (y) {
              if (x == 0 && y == 0) {
                return TileOption(
                    x: x, y: y, assetPath: StageMap.wall, type: TileType.start);
              }
              if (x == 9 && y == 9) {
                return TileOption(
                    x: x, y: y, assetPath: StageMap.wall, type: TileType.end);
              }
              if ((x == 2 && y == 2) ||
                  (x == 2 && y == 3) ||
                  (x == 2 && y == 5) ||
                  (x == 2 && y == 6) ||
                  (x == 4 && y == 3) ||
                  (x == 4 && y == 5) ||
                  (x == 4 && y == 6) ||
                  (x == 6 && y == 3) ||
                  (x == 6 && y == 5) ||
                  (x == 6 && y == 6) ||
                  (x == 8 && y == 3) ||
                  (x == 8 && y == 5) ||
                  (x == 8 && y == 6) ||
                  (x == 9 && y == 3) ||
                  (x == 0 && y == 5) ||
                  (x == 0 && y == 6) ||
                  (x == 0 && y == 3) ||
                  (x == 3 && y == 5) ||
                  (x == 3 && y == 6)) {
                return TileOption(
                    x: x,
                    y: y,
                    assetPath: StageMap.floor_2,
                    type: TileType.foundation);
              }
              return TileOption(
                  x: x, y: y, assetPath: StageMap.floor_3, type: TileType.road);
            });
          }).expand((i) => i)
        ]),
        waves: [
          const WaveOption(
            id: 0,
            count: 10,
            enemyType: EnemyType.goblin,
            unitInterval: Duration(milliseconds: 1000),
            nextWave: Duration(seconds: 10),
          ),
          const WaveOption(
            id: 1,
            count: 20,
            enemyType: EnemyType.goblin,
            unitInterval: Duration(milliseconds: 1000),
            nextWave: Duration.zero,
          ),
          const WaveOption(
            id: 1,
            count: 20,
            enemyType: EnemyType.goblin,
            unitInterval: Duration(milliseconds: 1000),
            nextWave: Duration.zero,
          ),
          const WaveOption(
            id: 1,
            count: 20,
            enemyType: EnemyType.goblin,
            unitInterval: Duration(milliseconds: 1000),
            nextWave: Duration.zero,
          ),
          const WaveOption(
            id: 1,
            count: 20,
            enemyType: EnemyType.goblin,
            unitInterval: Duration(milliseconds: 1000),
            nextWave: Duration.zero,
          ),
        ],
      );
      emitter(StageState.success(result));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  Future<void> _completed(
      _CompletedStageEvent event, Emitter<StageState> emitter) async {
    emitter(const StageState.processing());
//     try {
// // write something
//     } catch (error, stackTrace) {
//       //  e
//       //mitter(const StageState.failure());
//     }
  }
}
