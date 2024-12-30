// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Level {
  int get id => throw _privateConstructorUsedError;
  List<Wave> get waves => throw _privateConstructorUsedError;
}

/// @nodoc

class _$LevelImpl extends _Level {
  const _$LevelImpl({required this.id, required final List<Wave> waves})
      : _waves = waves,
        super._();

  @override
  final int id;
  final List<Wave> _waves;
  @override
  List<Wave> get waves {
    if (_waves is EqualUnmodifiableListView) return _waves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waves);
  }

  @override
  String toString() {
    return 'Level(id: $id, waves: $waves)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._waves, _waves));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_waves));
}

abstract class _Level extends Level {
  const factory _Level(
      {required final int id, required final List<Wave> waves}) = _$LevelImpl;
  const _Level._() : super._();

  @override
  int get id;
  @override
  List<Wave> get waves;
}
