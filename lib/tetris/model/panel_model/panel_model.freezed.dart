// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PanelModel {
  bool get hasBlock => throw _privateConstructorUsedError;
  TetrisColors get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PanelModelCopyWith<PanelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanelModelCopyWith<$Res> {
  factory $PanelModelCopyWith(
          PanelModel value, $Res Function(PanelModel) then) =
      _$PanelModelCopyWithImpl<$Res, PanelModel>;
  @useResult
  $Res call({bool hasBlock, TetrisColors color});
}

/// @nodoc
class _$PanelModelCopyWithImpl<$Res, $Val extends PanelModel>
    implements $PanelModelCopyWith<$Res> {
  _$PanelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasBlock = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      hasBlock: null == hasBlock
          ? _value.hasBlock
          : hasBlock // ignore: cast_nullable_to_non_nullable
              as bool,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as TetrisColors,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PanelModelImplCopyWith<$Res>
    implements $PanelModelCopyWith<$Res> {
  factory _$$PanelModelImplCopyWith(
          _$PanelModelImpl value, $Res Function(_$PanelModelImpl) then) =
      __$$PanelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasBlock, TetrisColors color});
}

/// @nodoc
class __$$PanelModelImplCopyWithImpl<$Res>
    extends _$PanelModelCopyWithImpl<$Res, _$PanelModelImpl>
    implements _$$PanelModelImplCopyWith<$Res> {
  __$$PanelModelImplCopyWithImpl(
      _$PanelModelImpl _value, $Res Function(_$PanelModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasBlock = null,
    Object? color = null,
  }) {
    return _then(_$PanelModelImpl(
      hasBlock: null == hasBlock
          ? _value.hasBlock
          : hasBlock // ignore: cast_nullable_to_non_nullable
              as bool,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as TetrisColors,
    ));
  }
}

/// @nodoc

class _$PanelModelImpl implements _PanelModel {
  const _$PanelModelImpl({required this.hasBlock, required this.color});

  @override
  final bool hasBlock;
  @override
  final TetrisColors color;

  @override
  String toString() {
    return 'PanelModel(hasBlock: $hasBlock, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanelModelImpl &&
            (identical(other.hasBlock, hasBlock) ||
                other.hasBlock == hasBlock) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasBlock, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanelModelImplCopyWith<_$PanelModelImpl> get copyWith =>
      __$$PanelModelImplCopyWithImpl<_$PanelModelImpl>(this, _$identity);
}

abstract class _PanelModel implements PanelModel {
  const factory _PanelModel(
      {required final bool hasBlock,
      required final TetrisColors color}) = _$PanelModelImpl;

  @override
  bool get hasBlock;
  @override
  TetrisColors get color;
  @override
  @JsonKey(ignore: true)
  _$$PanelModelImplCopyWith<_$PanelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
