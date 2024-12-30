import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'stage_treasury_bloc.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
sealed class StageTreasuryEvent with _$StageTreasuryEvent {
  const StageTreasuryEvent._();

  const factory StageTreasuryEvent.addGold(int value) = _$AddGoldEvent;

  const factory StageTreasuryEvent.subtractGold(int value) =
      _$SubtractGoldEvent;

  const factory StageTreasuryEvent.addMinerals(int value) = _$AddMineralsEvent;
  const factory StageTreasuryEvent.subtractMinerals(int value) =
      _$SubtractMineralsEvent;

  const factory StageTreasuryEvent.reset() = _$ResetEvent;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
class StageTreasuryState with _$StageTreasuryState {
  const StageTreasuryState._();

  const factory StageTreasuryState({
    required int gold,
    required int minerals,
  }) = $StageTreasuryState;
}

@lazySingleton
class StageTreasuryBloc extends Bloc<StageTreasuryEvent, StageTreasuryState> {
  StageTreasuryBloc() : super(const StageTreasuryState(gold: 0, minerals: 0)) {
    on<StageTreasuryEvent>(
      (event, emitter) {
        switch (event) {
          case _$AddGoldEvent():
            emitter(state.copyWith(gold: state.gold + event.value));
          case _$SubtractGoldEvent():
            emitter(state.copyWith(gold: state.gold - event.value));
          case _$AddMineralsEvent():
            emitter(state.copyWith(gold: state.minerals + event.value));
          case _$SubtractMineralsEvent():
            emitter(state.copyWith(gold: state.minerals - event.value));
          case _$ResetEvent():
            emitter(const StageTreasuryState(gold: 0, minerals: 0));
        }
      },
    );
  }
}
