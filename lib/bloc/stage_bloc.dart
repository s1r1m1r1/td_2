import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:td_2/domain/enums/enemy_type.dart';
import 'package:td_2/domain/wave_option.dart';

import '../domain/stage_option.dart';

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
      const result = StageOption(id: 0, waves: [
        WaveOption(
          id: 0,
          count: 5,
          enemyType: EnemyType.goblin,
          unitInterval: Duration(milliseconds: 1000),
          nextWave: Duration(seconds: 10),
        ),
        WaveOption(
          id: 1,
          count: 7,
          enemyType: EnemyType.goblin,
          unitInterval: Duration(milliseconds: 1000),
          nextWave: Duration.zero,
        ),
        WaveOption(
          id: 1,
          count: 2,
          enemyType: EnemyType.goblin,
          unitInterval: Duration(milliseconds: 1000),
          nextWave: Duration.zero,
        ),
        WaveOption(
          id: 1,
          count: 8,
          enemyType: EnemyType.goblin,
          unitInterval: Duration(milliseconds: 1000),
          nextWave: Duration.zero,
        ),
        WaveOption(
          id: 1,
          count: 5,
          enemyType: EnemyType.goblin,
          unitInterval: Duration(milliseconds: 1000),
          nextWave: Duration.zero,
        ),
      ]);
      emitter(const StageState.success(result));
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
