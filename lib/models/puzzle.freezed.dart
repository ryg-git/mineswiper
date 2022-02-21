// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'puzzle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PuzzleTearOff {
  const _$PuzzleTearOff();

  _Puzzle call({required List<Tile> tiles, int rowSize = 0, int colSize = 0}) {
    return _Puzzle(
      tiles: tiles,
      rowSize: rowSize,
      colSize: colSize,
    );
  }
}

/// @nodoc
const $Puzzle = _$PuzzleTearOff();

/// @nodoc
mixin _$Puzzle {
  List<Tile> get tiles => throw _privateConstructorUsedError;
  int get rowSize => throw _privateConstructorUsedError;
  int get colSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PuzzleCopyWith<Puzzle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PuzzleCopyWith<$Res> {
  factory $PuzzleCopyWith(Puzzle value, $Res Function(Puzzle) then) =
      _$PuzzleCopyWithImpl<$Res>;
  $Res call({List<Tile> tiles, int rowSize, int colSize});
}

/// @nodoc
class _$PuzzleCopyWithImpl<$Res> implements $PuzzleCopyWith<$Res> {
  _$PuzzleCopyWithImpl(this._value, this._then);

  final Puzzle _value;
  // ignore: unused_field
  final $Res Function(Puzzle) _then;

  @override
  $Res call({
    Object? tiles = freezed,
    Object? rowSize = freezed,
    Object? colSize = freezed,
  }) {
    return _then(_value.copyWith(
      tiles: tiles == freezed
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<Tile>,
      rowSize: rowSize == freezed
          ? _value.rowSize
          : rowSize // ignore: cast_nullable_to_non_nullable
              as int,
      colSize: colSize == freezed
          ? _value.colSize
          : colSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PuzzleCopyWith<$Res> implements $PuzzleCopyWith<$Res> {
  factory _$PuzzleCopyWith(_Puzzle value, $Res Function(_Puzzle) then) =
      __$PuzzleCopyWithImpl<$Res>;
  @override
  $Res call({List<Tile> tiles, int rowSize, int colSize});
}

/// @nodoc
class __$PuzzleCopyWithImpl<$Res> extends _$PuzzleCopyWithImpl<$Res>
    implements _$PuzzleCopyWith<$Res> {
  __$PuzzleCopyWithImpl(_Puzzle _value, $Res Function(_Puzzle) _then)
      : super(_value, (v) => _then(v as _Puzzle));

  @override
  _Puzzle get _value => super._value as _Puzzle;

  @override
  $Res call({
    Object? tiles = freezed,
    Object? rowSize = freezed,
    Object? colSize = freezed,
  }) {
    return _then(_Puzzle(
      tiles: tiles == freezed
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<Tile>,
      rowSize: rowSize == freezed
          ? _value.rowSize
          : rowSize // ignore: cast_nullable_to_non_nullable
              as int,
      colSize: colSize == freezed
          ? _value.colSize
          : colSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Puzzle extends _Puzzle with DiagnosticableTreeMixin {
  const _$_Puzzle({required this.tiles, this.rowSize = 0, this.colSize = 0})
      : super._();

  @override
  final List<Tile> tiles;
  @JsonKey()
  @override
  final int rowSize;
  @JsonKey()
  @override
  final int colSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Puzzle(tiles: $tiles, rowSize: $rowSize, colSize: $colSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Puzzle'))
      ..add(DiagnosticsProperty('tiles', tiles))
      ..add(DiagnosticsProperty('rowSize', rowSize))
      ..add(DiagnosticsProperty('colSize', colSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Puzzle &&
            const DeepCollectionEquality().equals(other.tiles, tiles) &&
            const DeepCollectionEquality().equals(other.rowSize, rowSize) &&
            const DeepCollectionEquality().equals(other.colSize, colSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tiles),
      const DeepCollectionEquality().hash(rowSize),
      const DeepCollectionEquality().hash(colSize));

  @JsonKey(ignore: true)
  @override
  _$PuzzleCopyWith<_Puzzle> get copyWith =>
      __$PuzzleCopyWithImpl<_Puzzle>(this, _$identity);
}

abstract class _Puzzle extends Puzzle {
  const factory _Puzzle({required List<Tile> tiles, int rowSize, int colSize}) =
      _$_Puzzle;
  const _Puzzle._() : super._();

  @override
  List<Tile> get tiles;
  @override
  int get rowSize;
  @override
  int get colSize;
  @override
  @JsonKey(ignore: true)
  _$PuzzleCopyWith<_Puzzle> get copyWith => throw _privateConstructorUsedError;
}
