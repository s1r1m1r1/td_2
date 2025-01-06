// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixin_radar_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MixinRadarConfig {
  RadarMode get radarMode => throw _privateConstructorUsedError;
  bool get radarOn => throw _privateConstructorUsedError;
  double get distScan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MixinRadarConfigCopyWith<MixinRadarConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixinRadarConfigCopyWith<$Res> {
  factory $MixinRadarConfigCopyWith(
          MixinRadarConfig value, $Res Function(MixinRadarConfig) then) =
      _$MixinRadarConfigCopyWithImpl<$Res, MixinRadarConfig>;
  @useResult
  $Res call({RadarMode radarMode, bool radarOn, double distScan});
}

/// @nodoc
class _$MixinRadarConfigCopyWithImpl<$Res, $Val extends MixinRadarConfig>
    implements $MixinRadarConfigCopyWith<$Res> {
  _$MixinRadarConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? radarMode = null,
    Object? radarOn = null,
    Object? distScan = null,
  }) {
    return _then(_value.copyWith(
      radarMode: null == radarMode
          ? _value.radarMode
          : radarMode // ignore: cast_nullable_to_non_nullable
              as RadarMode,
      radarOn: null == radarOn
          ? _value.radarOn
          : radarOn // ignore: cast_nullable_to_non_nullable
              as bool,
      distScan: null == distScan
          ? _value.distScan
          : distScan // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MixinRadarConfigImplCopyWith<$Res>
    implements $MixinRadarConfigCopyWith<$Res> {
  factory _$$MixinRadarConfigImplCopyWith(_$MixinRadarConfigImpl value,
          $Res Function(_$MixinRadarConfigImpl) then) =
      __$$MixinRadarConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RadarMode radarMode, bool radarOn, double distScan});
}

/// @nodoc
class __$$MixinRadarConfigImplCopyWithImpl<$Res>
    extends _$MixinRadarConfigCopyWithImpl<$Res, _$MixinRadarConfigImpl>
    implements _$$MixinRadarConfigImplCopyWith<$Res> {
  __$$MixinRadarConfigImplCopyWithImpl(_$MixinRadarConfigImpl _value,
      $Res Function(_$MixinRadarConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? radarMode = null,
    Object? radarOn = null,
    Object? distScan = null,
  }) {
    return _then(_$MixinRadarConfigImpl(
      radarMode: null == radarMode
          ? _value.radarMode
          : radarMode // ignore: cast_nullable_to_non_nullable
              as RadarMode,
      radarOn: null == radarOn
          ? _value.radarOn
          : radarOn // ignore: cast_nullable_to_non_nullable
              as bool,
      distScan: null == distScan
          ? _value.distScan
          : distScan // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MixinRadarConfigImpl extends _MixinRadarConfig {
  const _$MixinRadarConfigImpl(
      {this.radarMode = RadarMode.findBest,
      this.radarOn = true,
      required this.distScan})
      : super._();

  @override
  @JsonKey()
  final RadarMode radarMode;
  @override
  @JsonKey()
  final bool radarOn;
  @override
  final double distScan;

  @override
  String toString() {
    return 'MixinRadarConfig(radarMode: $radarMode, radarOn: $radarOn, distScan: $distScan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixinRadarConfigImpl &&
            (identical(other.radarMode, radarMode) ||
                other.radarMode == radarMode) &&
            (identical(other.radarOn, radarOn) || other.radarOn == radarOn) &&
            (identical(other.distScan, distScan) ||
                other.distScan == distScan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, radarMode, radarOn, distScan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixinRadarConfigImplCopyWith<_$MixinRadarConfigImpl> get copyWith =>
      __$$MixinRadarConfigImplCopyWithImpl<_$MixinRadarConfigImpl>(
          this, _$identity);
}

abstract class _MixinRadarConfig extends MixinRadarConfig {
  const factory _MixinRadarConfig(
      {final RadarMode radarMode,
      final bool radarOn,
      required final double distScan}) = _$MixinRadarConfigImpl;
  const _MixinRadarConfig._() : super._();

  @override
  RadarMode get radarMode;
  @override
  bool get radarOn;
  @override
  double get distScan;
  @override
  @JsonKey(ignore: true)
  _$$MixinRadarConfigImplCopyWith<_$MixinRadarConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
