// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixin_clash_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MixinClashConfig {
  ClashMode get mode => throw _privateConstructorUsedError;
  bool get radarOn => throw _privateConstructorUsedError;
  dynamic get effect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MixinClashConfigCopyWith<MixinClashConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixinClashConfigCopyWith<$Res> {
  factory $MixinClashConfigCopyWith(
          MixinClashConfig value, $Res Function(MixinClashConfig) then) =
      _$MixinClashConfigCopyWithImpl<$Res, MixinClashConfig>;
  @useResult
  $Res call({ClashMode mode, bool radarOn, dynamic effect});
}

/// @nodoc
class _$MixinClashConfigCopyWithImpl<$Res, $Val extends MixinClashConfig>
    implements $MixinClashConfigCopyWith<$Res> {
  _$MixinClashConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? radarOn = null,
    Object? effect = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ClashMode,
      radarOn: null == radarOn
          ? _value.radarOn
          : radarOn // ignore: cast_nullable_to_non_nullable
              as bool,
      effect: freezed == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MixinClashConfigImplCopyWith<$Res>
    implements $MixinClashConfigCopyWith<$Res> {
  factory _$$MixinClashConfigImplCopyWith(_$MixinClashConfigImpl value,
          $Res Function(_$MixinClashConfigImpl) then) =
      __$$MixinClashConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ClashMode mode, bool radarOn, dynamic effect});
}

/// @nodoc
class __$$MixinClashConfigImplCopyWithImpl<$Res>
    extends _$MixinClashConfigCopyWithImpl<$Res, _$MixinClashConfigImpl>
    implements _$$MixinClashConfigImplCopyWith<$Res> {
  __$$MixinClashConfigImplCopyWithImpl(_$MixinClashConfigImpl _value,
      $Res Function(_$MixinClashConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? radarOn = null,
    Object? effect = freezed,
  }) {
    return _then(_$MixinClashConfigImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ClashMode,
      radarOn: null == radarOn
          ? _value.radarOn
          : radarOn // ignore: cast_nullable_to_non_nullable
              as bool,
      effect: freezed == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$MixinClashConfigImpl extends _MixinClashConfig {
  const _$MixinClashConfigImpl(
      {this.mode = ClashMode.bestOne,
      this.radarOn = true,
      required this.effect})
      : super._();

  @override
  @JsonKey()
  final ClashMode mode;
  @override
  @JsonKey()
  final bool radarOn;
  @override
  final dynamic effect;

  @override
  String toString() {
    return 'MixinClashConfig(mode: $mode, radarOn: $radarOn, effect: $effect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixinClashConfigImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.radarOn, radarOn) || other.radarOn == radarOn) &&
            const DeepCollectionEquality().equals(other.effect, effect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, mode, radarOn, const DeepCollectionEquality().hash(effect));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixinClashConfigImplCopyWith<_$MixinClashConfigImpl> get copyWith =>
      __$$MixinClashConfigImplCopyWithImpl<_$MixinClashConfigImpl>(
          this, _$identity);
}

abstract class _MixinClashConfig extends MixinClashConfig {
  const factory _MixinClashConfig(
      {final ClashMode mode,
      final bool radarOn,
      required final dynamic effect}) = _$MixinClashConfigImpl;
  const _MixinClashConfig._() : super._();

  @override
  ClashMode get mode;
  @override
  bool get radarOn;
  @override
  dynamic get effect;
  @override
  @JsonKey(ignore: true)
  _$$MixinClashConfigImplCopyWith<_$MixinClashConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
