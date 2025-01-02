import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../domain/weapon_option.dart';
import '../flutter_core/constant/assets.dart';

part 'weapon_bar_bloc.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
sealed class WeaponBarEvent with _$WeaponBarEvent {
  const WeaponBarEvent._();
  const factory WeaponBarEvent.read() = _ReadWeaponBarEvent;
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
sealed class WeaponBarState with _$WeaponBarState {
  const WeaponBarState._();
  const factory WeaponBarState.init() = $InitWeaponBarState;
  const factory WeaponBarState.processing() = $ProcessingWeaponBarState;
  const factory WeaponBarState.success(List<WeaponOption> result) =
      $SuccessWeaponBarState;
}

@lazySingleton
class WeaponBarBloc extends Bloc<WeaponBarEvent, WeaponBarState> {
  WeaponBarBloc() : super(const $InitWeaponBarState()) {
    on<WeaponBarEvent>(
      (event, emitter) async {
        switch (event) {
          case _ReadWeaponBarEvent():
            await _read(event, emitter);
        }
      },
    );
  }

  FutureOr<void> _read(
      _ReadWeaponBarEvent event, Emitter<WeaponBarState> emitter) async {
    emitter(const WeaponBarState.processing());
    try {
      emitter(
        WeaponBarState.success(
          [
            WeaponOption.cannon(
              id: const WeaponId(0),
              radarDistance: 2,
              bulletSpeed: 2,
              bulletDistance: 3,
              price: 100,
              barImage:  AssetImage(Assets.images.cannon),
            ),
            WeaponOption.missile(
              id: const WeaponId(1),
              radarDistance: 2,
              bulletSpeed: 2,
              bulletDistance: 3,
              price: 100,
              barImage: AssetImage(Assets.images.missile),
            )
          ],
        ),
      );
    } catch (error) {
      addError(error);
    }
    // ...
  }
}
