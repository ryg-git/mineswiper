// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TileTearOff {
  const _$TileTearOff();

  _Tile call({required Position position, bool isWhiteSpace = false}) {
    return _Tile(
      position: position,
      isWhiteSpace: isWhiteSpace,
    );
  }
}

/// @nodoc
const $Tile = _$TileTearOff();

/// @nodoc
mixin _$Tile {
  Position get position => throw _privateConstructorUsedError;
  bool get isWhiteSpace => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TileCopyWith<Tile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileCopyWith<$Res> {
  factory $TileCopyWith(Tile value, $Res Function(Tile) then) =
      _$TileCopyWithImpl<$Res>;
  $Res call({Position position, bool isWhiteSpace});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$TileCopyWithImpl<$Res> implements $TileCopyWith<$Res> {
  _$TileCopyWithImpl(this._value, this._then);

  final Tile _value;
  // ignore: unused_field
  final $Res Function(Tile) _then;

  @override
  $Res call({
    Object? position = freezed,
    Object? isWhiteSpace = freezed,
  }) {
    return _then(_value.copyWith(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      isWhiteSpace: isWhiteSpace == freezed
          ? _value.isWhiteSpace
          : isWhiteSpace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value));
    });
  }
}

/// @nodoc
abstract class _$TileCopyWith<$Res> implements $TileCopyWith<$Res> {
  factory _$TileCopyWith(_Tile value, $Res Function(_Tile) then) =
      __$TileCopyWithImpl<$Res>;
  @override
  $Res call({Position position, bool isWhiteSpace});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$TileCopyWithImpl<$Res> extends _$TileCopyWithImpl<$Res>
    implements _$TileCopyWith<$Res> {
  __$TileCopyWithImpl(_Tile _value, $Res Function(_Tile) _then)
      : super(_value, (v) => _then(v as _Tile));

  @override
  _Tile get _value => super._value as _Tile;

  @override
  $Res call({
    Object? position = freezed,
    Object? isWhiteSpace = freezed,
  }) {
    return _then(_Tile(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      isWhiteSpace: isWhiteSpace == freezed
          ? _value.isWhiteSpace
          : isWhiteSpace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Tile extends _Tile with DiagnosticableTreeMixin {
  const _$_Tile({required this.position, this.isWhiteSpace = false})
      : super._();

  @override
  final Position position;
  @JsonKey()
  @override
  final bool isWhiteSpace;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Tile(position: $position, isWhiteSpace: $isWhiteSpace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Tile'))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('isWhiteSpace', isWhiteSpace));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tile &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality()
                .equals(other.isWhiteSpace, isWhiteSpace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(isWhiteSpace));

  @JsonKey(ignore: true)
  @override
  _$TileCopyWith<_Tile> get copyWith =>
      __$TileCopyWithImpl<_Tile>(this, _$identity);
}

abstract class _Tile extends Tile {
  const factory _Tile({required Position position, bool isWhiteSpace}) =
      _$_Tile;
  const _Tile._() : super._();

  @override
  Position get position;
  @override
  bool get isWhiteSpace;
  @override
  @JsonKey(ignore: true)
  _$TileCopyWith<_Tile> get copyWith => throw _privateConstructorUsedError;
}
