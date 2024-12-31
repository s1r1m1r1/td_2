// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StageEvent {}

/// @nodoc

class _$ReadStageEventImpl extends _ReadStageEvent {
  const _$ReadStageEventImpl() : super._();

  @override
  String toString() {
    return 'StageEvent.read()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReadStageEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _ReadStageEvent extends StageEvent {
  const factory _ReadStageEvent() = _$ReadStageEventImpl;
  const _ReadStageEvent._() : super._();
}

/// @nodoc

class _$CompletedStageEventImpl extends _CompletedStageEvent {
  const _$CompletedStageEventImpl() : super._();

  @override
  String toString() {
    return 'StageEvent.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedStageEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _CompletedStageEvent extends StageEvent {
  const factory _CompletedStageEvent() = _$CompletedStageEventImpl;
  const _CompletedStageEvent._() : super._();
}

/// @nodoc
mixin _$StageState {}

/// @nodoc
abstract class $StageStateCopyWith<$Res> {
  factory $StageStateCopyWith(
          StageState value, $Res Function(StageState) then) =
      _$StageStateCopyWithImpl<$Res, StageState>;
}

/// @nodoc
class _$StageStateCopyWithImpl<$Res, $Val extends StageState>
    implements $StageStateCopyWith<$Res> {
  _$StageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$$InitStageStateImplCopyWith<$Res> {
  factory _$$$InitStageStateImplCopyWith(_$$InitStageStateImpl value,
          $Res Function(_$$InitStageStateImpl) then) =
      __$$$InitStageStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$$InitStageStateImplCopyWithImpl<$Res>
    extends _$StageStateCopyWithImpl<$Res, _$$InitStageStateImpl>
    implements _$$$InitStageStateImplCopyWith<$Res> {
  __$$$InitStageStateImplCopyWithImpl(
      _$$InitStageStateImpl _value, $Res Function(_$$InitStageStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$$InitStageStateImpl extends $InitStageState {
  const _$$InitStageStateImpl() : super._();

  @override
  String toString() {
    return 'StageState.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$$InitStageStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class $InitStageState extends StageState {
  const factory $InitStageState() = _$$InitStageStateImpl;
  const $InitStageState._() : super._();
}

/// @nodoc
abstract class _$$$ProcessingStageStateImplCopyWith<$Res> {
  factory _$$$ProcessingStageStateImplCopyWith(
          _$$ProcessingStageStateImpl value,
          $Res Function(_$$ProcessingStageStateImpl) then) =
      __$$$ProcessingStageStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$$ProcessingStageStateImplCopyWithImpl<$Res>
    extends _$StageStateCopyWithImpl<$Res, _$$ProcessingStageStateImpl>
    implements _$$$ProcessingStageStateImplCopyWith<$Res> {
  __$$$ProcessingStageStateImplCopyWithImpl(_$$ProcessingStageStateImpl _value,
      $Res Function(_$$ProcessingStageStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$$ProcessingStageStateImpl extends $ProcessingStageState {
  const _$$ProcessingStageStateImpl() : super._();

  @override
  String toString() {
    return 'StageState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$ProcessingStageStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class $ProcessingStageState extends StageState {
  const factory $ProcessingStageState() = _$$ProcessingStageStateImpl;
  const $ProcessingStageState._() : super._();
}

/// @nodoc
abstract class _$$$SuccessStageStateImplCopyWith<$Res> {
  factory _$$$SuccessStageStateImplCopyWith(_$$SuccessStageStateImpl value,
          $Res Function(_$$SuccessStageStateImpl) then) =
      __$$$SuccessStageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StageOption result});
}

/// @nodoc
class __$$$SuccessStageStateImplCopyWithImpl<$Res>
    extends _$StageStateCopyWithImpl<$Res, _$$SuccessStageStateImpl>
    implements _$$$SuccessStageStateImplCopyWith<$Res> {
  __$$$SuccessStageStateImplCopyWithImpl(_$$SuccessStageStateImpl _value,
      $Res Function(_$$SuccessStageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
  }) {
    return _then(_$$SuccessStageStateImpl(
      null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as StageOption,
    ));
  }
}

/// @nodoc

class _$$SuccessStageStateImpl extends $SuccessStageState {
  const _$$SuccessStageStateImpl(this.result) : super._();

  @override
  final StageOption result;

  @override
  String toString() {
    return 'StageState.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$SuccessStageStateImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$SuccessStageStateImplCopyWith<_$$SuccessStageStateImpl> get copyWith =>
      __$$$SuccessStageStateImplCopyWithImpl<_$$SuccessStageStateImpl>(
          this, _$identity);
}

abstract class $SuccessStageState extends StageState {
  const factory $SuccessStageState(final StageOption result) =
      _$$SuccessStageStateImpl;
  const $SuccessStageState._() : super._();

  StageOption get result;
  @JsonKey(ignore: true)
  _$$$SuccessStageStateImplCopyWith<_$$SuccessStageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
