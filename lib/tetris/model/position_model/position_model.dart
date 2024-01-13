import 'package:flutter_tetris/tetris/config/configs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'position_model.freezed.dart';

/// →x,↓y

@freezed
class PositionModel with _$PositionModel {
  const factory PositionModel({
    required int x,
    required int y,
  }) = _PositionModel;

  factory PositionModel.init() => const PositionModel(
        x: horizontalStartPosition,
        y: verticalStartPosition,
      );
}
