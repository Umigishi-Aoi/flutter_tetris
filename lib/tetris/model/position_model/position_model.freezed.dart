// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'position_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PositionModel {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PositionModelCopyWith<PositionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionModelCopyWith<$Res> {
  factory $PositionModelCopyWith(
          PositionModel value, $Res Function(PositionModel) then) =
      _$PositionModelCopyWithImpl<$Res, PositionModel>;
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class _$PositionModelCopyWithImpl<$Res, $Val extends PositionModel>
    implements $PositionModelCopyWith<$Res> {
  _$PositionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PositionModelImplCopyWith<$Res>
    implements $PositionModelCopyWith<$Res> {
  factory _$$PositionModelImplCopyWith(
          _$PositionModelImpl value, $Res Function(_$PositionModelImpl) then) =
      __$$PositionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$PositionModelImplCopyWithImpl<$Res>
    extends _$PositionModelCopyWithImpl<$Res, _$PositionModelImpl>
    implements _$$PositionModelImplCopyWith<$Res> {
  __$$PositionModelImplCopyWithImpl(
      _$PositionModelImpl _value, $Res Function(_$PositionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$PositionModelImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PositionModelImpl implements _PositionModel {
  const _$PositionModelImpl({required this.x, required this.y});

  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'PositionModel(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionModelImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionModelImplCopyWith<_$PositionModelImpl> get copyWith =>
      __$$PositionModelImplCopyWithImpl<_$PositionModelImpl>(this, _$identity);
}

abstract class _PositionModel implements PositionModel {
  const factory _PositionModel({required final int x, required final int y}) =
      _$PositionModelImpl;

  @override
  int get x;
  @override
  int get y;
  @override
  @JsonKey(ignore: true)
  _$$PositionModelImplCopyWith<_$PositionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
