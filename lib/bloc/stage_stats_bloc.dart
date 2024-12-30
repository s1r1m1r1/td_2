import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'stage_stats_bloc.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class StageStatsEvent with _$StageStatsEvent {
  const StageStatsEvent._();
  const factory StageStatsEvent.reset() = _$ResetEvent;
  const factory StageStatsEvent.incrementEnemyKilled() =
      _$IncrementEnemyKilledEvent;
  const factory StageStatsEvent.incrementEnemyMissed() =
      _$IncrementEnemyMissedEvent;
  const factory StageStatsEvent.incrementWave() = _$IncrementWaveEvent;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
sealed class StageStatsState with _$StageStatsState {
  const StageStatsState._();
  const factory StageStatsState({
    required int wave,
    required int enemyKilled,
    required int enemyMissed,
  }) = $StageStatsState;
}

@lazySingleton
class StageStatsBloc extends Bloc<StageStatsEvent, StageStatsState> {
  StageStatsBloc()
      : super(
          const StageStatsState(
            wave: 0,
            enemyKilled: 0,
            enemyMissed: 0,
          ),
        ) {
    on<StageStatsEvent>(
      (event, emitter) {
        switch (event) {
          case _$IncrementEnemyKilledEvent():
            emitter(state.copyWith(enemyKilled: state.enemyKilled + 1));
          case _$IncrementEnemyMissedEvent():
            emitter(state.copyWith(enemyKilled: state.enemyMissed + 1));
          case _$IncrementWaveEvent():
            emitter(state.copyWith(enemyKilled: state.wave + 1));
          case _$ResetEvent():
            emitter(const StageStatsState(
              wave: 0,
              enemyKilled: 0,
              enemyMissed: 0,
            ));
        }
      },
    );
  }
}
