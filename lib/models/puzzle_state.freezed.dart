// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'puzzle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PuzzleStateTearOff {
  const _$PuzzleStateTearOff();

  _PuzzleState call(
      {required Puzzle puzzle,
      int remainingMines = 0,
      int numberOfMoves = 0,
      Tile? lastTappedTile,
      PuzzleStatus puzzleStatus = PuzzleStatus.incomplete,
      TileMovementStatus tileMovementStatus =
          TileMovementStatus.nothingTapped}) {
    return _PuzzleState(
      puzzle: puzzle,
      remainingMines: remainingMines,
      numberOfMoves: numberOfMoves,
      lastTappedTile: lastTappedTile,
      puzzleStatus: puzzleStatus,
      tileMovementStatus: tileMovementStatus,
    );
  }
}

/// @nodoc
const $PuzzleState = _$PuzzleStateTearOff();

/// @nodoc
mixin _$PuzzleState {
  Puzzle get puzzle => throw _privateConstructorUsedError;
  int get remainingMines => throw _privateConstructorUsedError;
  int get numberOfMoves => throw _privateConstructorUsedError;
  Tile? get lastTappedTile => throw _privateConstructorUsedError;
  PuzzleStatus get puzzleStatus => throw _privateConstructorUsedError;
  TileMovementStatus get tileMovementStatus =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PuzzleStateCopyWith<PuzzleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PuzzleStateCopyWith<$Res> {
  factory $PuzzleStateCopyWith(
          PuzzleState value, $Res Function(PuzzleState) then) =
      _$PuzzleStateCopyWithImpl<$Res>;
  $Res call(
      {Puzzle puzzle,
      int remainingMines,
      int numberOfMoves,
      Tile? lastTappedTile,
      PuzzleStatus puzzleStatus,
      TileMovementStatus tileMovementStatus});

  $PuzzleCopyWith<$Res> get puzzle;
  $TileCopyWith<$Res>? get lastTappedTile;
}

/// @nodoc
class _$PuzzleStateCopyWithImpl<$Res> implements $PuzzleStateCopyWith<$Res> {
  _$PuzzleStateCopyWithImpl(this._value, this._then);

  final PuzzleState _value;
  // ignore: unused_field
  final $Res Function(PuzzleState) _then;

  @override
  $Res call({
    Object? puzzle = freezed,
    Object? remainingMines = freezed,
    Object? numberOfMoves = freezed,
    Object? lastTappedTile = freezed,
    Object? puzzleStatus = freezed,
    Object? tileMovementStatus = freezed,
  }) {
    return _then(_value.copyWith(
      puzzle: puzzle == freezed
          ? _value.puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as Puzzle,
      remainingMines: remainingMines == freezed
          ? _value.remainingMines
          : remainingMines // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfMoves: numberOfMoves == freezed
          ? _value.numberOfMoves
          : numberOfMoves // ignore: cast_nullable_to_non_nullable
              as int,
      lastTappedTile: lastTappedTile == freezed
          ? _value.lastTappedTile
          : lastTappedTile // ignore: cast_nullable_to_non_nullable
              as Tile?,
      puzzleStatus: puzzleStatus == freezed
          ? _value.puzzleStatus
          : puzzleStatus // ignore: cast_nullable_to_non_nullable
              as PuzzleStatus,
      tileMovementStatus: tileMovementStatus == freezed
          ? _value.tileMovementStatus
          : tileMovementStatus // ignore: cast_nullable_to_non_nullable
              as TileMovementStatus,
    ));
  }

  @override
  $PuzzleCopyWith<$Res> get puzzle {
    return $PuzzleCopyWith<$Res>(_value.puzzle, (value) {
      return _then(_value.copyWith(puzzle: value));
    });
  }

  @override
  $TileCopyWith<$Res>? get lastTappedTile {
    if (_value.lastTappedTile == null) {
      return null;
    }

    return $TileCopyWith<$Res>(_value.lastTappedTile!, (value) {
      return _then(_value.copyWith(lastTappedTile: value));
    });
  }
}

/// @nodoc
abstract class _$PuzzleStateCopyWith<$Res>
    implements $PuzzleStateCopyWith<$Res> {
  factory _$PuzzleStateCopyWith(
          _PuzzleState value, $Res Function(_PuzzleState) then) =
      __$PuzzleStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Puzzle puzzle,
      int remainingMines,
      int numberOfMoves,
      Tile? lastTappedTile,
      PuzzleStatus puzzleStatus,
      TileMovementStatus tileMovementStatus});

  @override
  $PuzzleCopyWith<$Res> get puzzle;
  @override
  $TileCopyWith<$Res>? get lastTappedTile;
}

/// @nodoc
class __$PuzzleStateCopyWithImpl<$Res> extends _$PuzzleStateCopyWithImpl<$Res>
    implements _$PuzzleStateCopyWith<$Res> {
  __$PuzzleStateCopyWithImpl(
      _PuzzleState _value, $Res Function(_PuzzleState) _then)
      : super(_value, (v) => _then(v as _PuzzleState));

  @override
  _PuzzleState get _value => super._value as _PuzzleState;

  @override
  $Res call({
    Object? puzzle = freezed,
    Object? remainingMines = freezed,
    Object? numberOfMoves = freezed,
    Object? lastTappedTile = freezed,
    Object? puzzleStatus = freezed,
    Object? tileMovementStatus = freezed,
  }) {
    return _then(_PuzzleState(
      puzzle: puzzle == freezed
          ? _value.puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as Puzzle,
      remainingMines: remainingMines == freezed
          ? _value.remainingMines
          : remainingMines // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfMoves: numberOfMoves == freezed
          ? _value.numberOfMoves
          : numberOfMoves // ignore: cast_nullable_to_non_nullable
              as int,
      lastTappedTile: lastTappedTile == freezed
          ? _value.lastTappedTile
          : lastTappedTile // ignore: cast_nullable_to_non_nullable
              as Tile?,
      puzzleStatus: puzzleStatus == freezed
          ? _value.puzzleStatus
          : puzzleStatus // ignore: cast_nullable_to_non_nullable
              as PuzzleStatus,
      tileMovementStatus: tileMovementStatus == freezed
          ? _value.tileMovementStatus
          : tileMovementStatus // ignore: cast_nullable_to_non_nullable
              as TileMovementStatus,
    ));
  }
}

/// @nodoc

class _$_PuzzleState with DiagnosticableTreeMixin implements _PuzzleState {
  const _$_PuzzleState(
      {required this.puzzle,
      this.remainingMines = 0,
      this.numberOfMoves = 0,
      this.lastTappedTile,
      this.puzzleStatus = PuzzleStatus.incomplete,
      this.tileMovementStatus = TileMovementStatus.nothingTapped});

  @override
  final Puzzle puzzle;
  @JsonKey()
  @override
  final int remainingMines;
  @JsonKey()
  @override
  final int numberOfMoves;
  @override
  final Tile? lastTappedTile;
  @JsonKey()
  @override
  final PuzzleStatus puzzleStatus;
  @JsonKey()
  @override
  final TileMovementStatus tileMovementStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PuzzleState(puzzle: $puzzle, remainingMines: $remainingMines, numberOfMoves: $numberOfMoves, lastTappedTile: $lastTappedTile, puzzleStatus: $puzzleStatus, tileMovementStatus: $tileMovementStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PuzzleState'))
      ..add(DiagnosticsProperty('puzzle', puzzle))
      ..add(DiagnosticsProperty('remainingMines', remainingMines))
      ..add(DiagnosticsProperty('numberOfMoves', numberOfMoves))
      ..add(DiagnosticsProperty('lastTappedTile', lastTappedTile))
      ..add(DiagnosticsProperty('puzzleStatus', puzzleStatus))
      ..add(DiagnosticsProperty('tileMovementStatus', tileMovementStatus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PuzzleState &&
            const DeepCollectionEquality().equals(other.puzzle, puzzle) &&
            const DeepCollectionEquality()
                .equals(other.remainingMines, remainingMines) &&
            const DeepCollectionEquality()
                .equals(other.numberOfMoves, numberOfMoves) &&
            const DeepCollectionEquality()
                .equals(other.lastTappedTile, lastTappedTile) &&
            const DeepCollectionEquality()
                .equals(other.puzzleStatus, puzzleStatus) &&
            const DeepCollectionEquality()
                .equals(other.tileMovementStatus, tileMovementStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(puzzle),
      const DeepCollectionEquality().hash(remainingMines),
      const DeepCollectionEquality().hash(numberOfMoves),
      const DeepCollectionEquality().hash(lastTappedTile),
      const DeepCollectionEquality().hash(puzzleStatus),
      const DeepCollectionEquality().hash(tileMovementStatus));

  @JsonKey(ignore: true)
  @override
  _$PuzzleStateCopyWith<_PuzzleState> get copyWith =>
      __$PuzzleStateCopyWithImpl<_PuzzleState>(this, _$identity);
}

abstract class _PuzzleState implements PuzzleState {
  const factory _PuzzleState(
      {required Puzzle puzzle,
      int remainingMines,
      int numberOfMoves,
      Tile? lastTappedTile,
      PuzzleStatus puzzleStatus,
      TileMovementStatus tileMovementStatus}) = _$_PuzzleState;

  @override
  Puzzle get puzzle;
  @override
  int get remainingMines;
  @override
  int get numberOfMoves;
  @override
  Tile? get lastTappedTile;
  @override
  PuzzleStatus get puzzleStatus;
  @override
  TileMovementStatus get tileMovementStatus;
  @override
  @JsonKey(ignore: true)
  _$PuzzleStateCopyWith<_PuzzleState> get copyWith =>
      throw _privateConstructorUsedError;
}
