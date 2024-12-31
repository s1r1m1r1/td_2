// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LayerOption {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  List<TileOption> get tiles => throw _privateConstructorUsedError;
}

/// @nodoc

class _$LayerOptionImpl extends _LayerOption {
  const _$LayerOptionImpl(
      {required this.width,
      required this.height,
      required final List<TileOption> tiles})
      : _tiles = tiles,
        super._();

  @override
  final int width;
  @override
  final int height;
  final List<TileOption> _tiles;
  @override
  List<TileOption> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  String toString() {
    return 'LayerOption(width: $width, height: $height, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerOptionImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, width, height, const DeepCollectionEquality().hash(_tiles));
}

abstract class _LayerOption extends LayerOption {
  const factory _LayerOption(
      {required final int width,
      required final int height,
      required final List<TileOption> tiles}) = _$LayerOptionImpl;
  const _LayerOption._() : super._();

  @override
  int get width;
  @override
  int get height;
  @override
  List<TileOption> get tiles;
}

/// @nodoc
mixin _$TileOption {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  String get assetPath => throw _privateConstructorUsedError;
  TileType get type => throw _privateConstructorUsedError;
}

/// @nodoc

class _$TileOptionImpl extends _TileOption {
  const _$TileOptionImpl(
      {required this.x,
      required this.y,
      required this.assetPath,
      required this.type})
      : super._();

  @override
  final int x;
  @override
  final int y;
  @override
  final String assetPath;
  @override
  final TileType type;

  @override
  String toString() {
    return 'TileOption(x: $x, y: $y, assetPath: $assetPath, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileOptionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.assetPath, assetPath) ||
                other.assetPath == assetPath) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y, assetPath, type);
}

abstract class _TileOption extends TileOption {
  const factory _TileOption(
      {required final int x,
      required final int y,
      required final String assetPath,
      required final TileType type}) = _$TileOptionImpl;
  const _TileOption._() : super._();

  @override
  int get x;
  @override
  int get y;
  @override
  String get assetPath;
  @override
  TileType get type;
}
