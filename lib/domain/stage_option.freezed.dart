// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StageOption {
  int get id => throw _privateConstructorUsedError;
  List<WaveOption> get waves => throw _privateConstructorUsedError;
  LayerOption get layer => throw _privateConstructorUsedError;
}

/// @nodoc

class _$StageOptionImpl extends _StageOption {
  const _$StageOptionImpl(
      {required this.id,
      required final List<WaveOption> waves,
      required this.layer})
      : _waves = waves,
        super._();

  @override
  final int id;
  final List<WaveOption> _waves;
  @override
  List<WaveOption> get waves {
    if (_waves is EqualUnmodifiableListView) return _waves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waves);
  }

  @override
  final LayerOption layer;

  @override
  String toString() {
    return 'StageOption(id: $id, waves: $waves, layer: $layer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._waves, _waves) &&
            (identical(other.layer, layer) || other.layer == layer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_waves), layer);
}

abstract class _StageOption extends StageOption {
  const factory _StageOption(
      {required final int id,
      required final List<WaveOption> waves,
      required final LayerOption layer}) = _$StageOptionImpl;
  const _StageOption._() : super._();

  @override
  int get id;
  @override
  List<WaveOption> get waves;
  @override
  LayerOption get layer;
}
