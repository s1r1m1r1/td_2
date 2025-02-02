import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame/cache.dart';
import 'package:flutter/widgets.dart';

import '../../../generated/assets.gen.dart';


part 'preload_state.dart';

class PreloadCubit extends Cubit<PreloadState> {
  PreloadCubit(this.images, this.audio) : super(const PreloadState.initial());

  final Images images;
  final AudioCache audio;

  /// Load items sequentially allows display of what is being loaded
  Future<void> loadSequentially() async {
    final phases = [
      PreloadPhase(
        label: 'audio',
        loader: () => audio.loadAll([
          Assets.audio.music.bgMusic,
          Assets.audio.sfx.fire1,
          Assets.audio.sfx.fire2,
        ]),
      ),
      PreloadPhase(
        label: 'images',
        loader: () => images
            .loadAll([...Assets.images.weapon.values.map((i) => i.path)]),
      ),
    ];

    emit(state.copyWith(totalCount: phases.length));
    for (final phase in phases) {
      emit(state.copyWith(currentLabel: phase.label));
      // Throttle phases to take at least 1/5 seconds
      try {
        await Future.wait([
          Future.delayed(Duration.zero, phase.loader),
          Future<void>.delayed(const Duration(milliseconds: 200)),
        ]);
      } catch (error, stack) {
        addError(error, stack);
      }
      emit(state.copyWith(loadedCount: state.loadedCount + 1));
    }
    emit(state.copyWith(completed: true));
  }
}

@immutable
class PreloadPhase {
  const PreloadPhase({
    required this.label,
    required this.loader,
  });

  final String label;
  final Future<void> Function() loader;
}
