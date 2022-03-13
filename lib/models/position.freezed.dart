// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PositionTearOff {
  const _$PositionTearOff();

  _Position call(
      {required int x,
      required int y,
      int mines = 4,
      bool isMine = false,
      bool isFlagged = false,
      bool isVisited = false,
      bool isDefused = false,
      bool showHint = false}) {
    return _Position(
      x: x,
      y: y,
      mines: mines,
      isMine: isMine,
      isFlagged: isFlagged,
      isVisited: isVisited,
      isDefused: isDefused,
      showHint: showHint,
    );
  }
}

/// @nodoc
const $Position = _$PositionTearOff();

/// @nodoc
mixin _$Position {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get mines => throw _privateConstructorUsedError;
  bool get isMine => throw _privateConstructorUsedError;
  bool get isFlagged => throw _privateConstructorUsedError;
  bool get isVisited => throw _privateConstructorUsedError;
  bool get isDefused => throw _privateConstructorUsedError;
  bool get showHint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res>;
  $Res call(
      {int x,
      int y,
      int mines,
      bool isMine,
      bool isFlagged,
      bool isVisited,
      bool isDefused,
      bool showHint});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res> implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  final Position _value;
  // ignore: unused_field
  final $Res Function(Position) _then;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? mines = freezed,
    Object? isMine = freezed,
    Object? isFlagged = freezed,
    Object? isVisited = freezed,
    Object? isDefused = freezed,
    Object? showHint = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      mines: mines == freezed
          ? _value.mines
          : mines // ignore: cast_nullable_to_non_nullable
              as int,
      isMine: isMine == freezed
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlagged: isFlagged == freezed
          ? _value.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisited: isVisited == freezed
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefused: isDefused == freezed
          ? _value.isDefused
          : isDefused // ignore: cast_nullable_to_non_nullable
              as bool,
      showHint: showHint == freezed
          ? _value.showHint
          : showHint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PositionCopyWith<$Res> implements $PositionCopyWith<$Res> {
  factory _$PositionCopyWith(_Position value, $Res Function(_Position) then) =
      __$PositionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int x,
      int y,
      int mines,
      bool isMine,
      bool isFlagged,
      bool isVisited,
      bool isDefused,
      bool showHint});
}

/// @nodoc
class __$PositionCopyWithImpl<$Res> extends _$PositionCopyWithImpl<$Res>
    implements _$PositionCopyWith<$Res> {
  __$PositionCopyWithImpl(_Position _value, $Res Function(_Position) _then)
      : super(_value, (v) => _then(v as _Position));

  @override
  _Position get _value => super._value as _Position;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? mines = freezed,
    Object? isMine = freezed,
    Object? isFlagged = freezed,
    Object? isVisited = freezed,
    Object? isDefused = freezed,
    Object? showHint = freezed,
  }) {
    return _then(_Position(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      mines: mines == freezed
          ? _value.mines
          : mines // ignore: cast_nullable_to_non_nullable
              as int,
      isMine: isMine == freezed
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlagged: isFlagged == freezed
          ? _value.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisited: isVisited == freezed
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefused: isDefused == freezed
          ? _value.isDefused
          : isDefused // ignore: cast_nullable_to_non_nullable
              as bool,
      showHint: showHint == freezed
          ? _value.showHint
          : showHint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Position extends _Position with DiagnosticableTreeMixin {
  const _$_Position(
      {required this.x,
      required this.y,
      this.mines = 4,
      this.isMine = false,
      this.isFlagged = false,
      this.isVisited = false,
      this.isDefused = false,
      this.showHint = false})
      : super._();

  @override
  final int x;
  @override
  final int y;
  @JsonKey()
  @override
  final int mines;
  @JsonKey()
  @override
  final bool isMine;
  @JsonKey()
  @override
  final bool isFlagged;
  @JsonKey()
  @override
  final bool isVisited;
  @JsonKey()
  @override
  final bool isDefused;
  @JsonKey()
  @override
  final bool showHint;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Position(x: $x, y: $y, mines: $mines, isMine: $isMine, isFlagged: $isFlagged, isVisited: $isVisited, isDefused: $isDefused, showHint: $showHint)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Position'))
      ..add(DiagnosticsProperty('x', x))
      ..add(DiagnosticsProperty('y', y))
      ..add(DiagnosticsProperty('mines', mines))
      ..add(DiagnosticsProperty('isMine', isMine))
      ..add(DiagnosticsProperty('isFlagged', isFlagged))
      ..add(DiagnosticsProperty('isVisited', isVisited))
      ..add(DiagnosticsProperty('isDefused', isDefused))
      ..add(DiagnosticsProperty('showHint', showHint));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Position &&
            const DeepCollectionEquality().equals(other.x, x) &&
            const DeepCollectionEquality().equals(other.y, y) &&
            const DeepCollectionEquality().equals(other.mines, mines) &&
            const DeepCollectionEquality().equals(other.isMine, isMine) &&
            const DeepCollectionEquality().equals(other.isFlagged, isFlagged) &&
            const DeepCollectionEquality().equals(other.isVisited, isVisited) &&
            const DeepCollectionEquality().equals(other.isDefused, isDefused) &&
            const DeepCollectionEquality().equals(other.showHint, showHint));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(x),
      const DeepCollectionEquality().hash(y),
      const DeepCollectionEquality().hash(mines),
      const DeepCollectionEquality().hash(isMine),
      const DeepCollectionEquality().hash(isFlagged),
      const DeepCollectionEquality().hash(isVisited),
      const DeepCollectionEquality().hash(isDefused),
      const DeepCollectionEquality().hash(showHint));

  @JsonKey(ignore: true)
  @override
  _$PositionCopyWith<_Position> get copyWith =>
      __$PositionCopyWithImpl<_Position>(this, _$identity);
}

abstract class _Position extends Position {
  const factory _Position(
      {required int x,
      required int y,
      int mines,
      bool isMine,
      bool isFlagged,
      bool isVisited,
      bool isDefused,
      bool showHint}) = _$_Position;
  const _Position._() : super._();

  @override
  int get x;
  @override
  int get y;
  @override
  int get mines;
  @override
  bool get isMine;
  @override
  bool get isFlagged;
  @override
  bool get isVisited;
  @override
  bool get isDefused;
  @override
  bool get showHint;
  @override
  @JsonKey(ignore: true)
  _$PositionCopyWith<_Position> get copyWith =>
      throw _privateConstructorUsedError;
}
