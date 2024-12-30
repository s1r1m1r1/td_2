import 'package:freezed_annotation/freezed_annotation.dart';

import 'wave.dart';
part 'stage.freezed.dart';

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: false)
class Stage with _$Stage {
  const Stage._();
  const factory Stage({
    required int id,
    required List<Wave> waves,
  }) = _Stage;
}
