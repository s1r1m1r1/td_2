import 'package:freezed_annotation/freezed_annotation.dart';
part 'mixin_clash_config.freezed.dart';

enum ClashMode {
  bestOne,
  collision,
}

@Freezed(
    map: FreezedMapOptions.none, when: FreezedWhenOptions.none, copyWith: true)
class MixinClashConfig with _$MixinClashConfig {
  const MixinClashConfig._();
  const factory MixinClashConfig({
    @Default(ClashMode.bestOne) ClashMode mode,
    @Default(true) bool radarOn,
    required dynamic effect,
  }) = _MixinClashConfig;
}
