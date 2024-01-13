import 'package:flutter_tetris/tetris/config/tetris_colors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'panel_model.freezed.dart';

@freezed
class PanelModel with _$PanelModel {
  const factory PanelModel({
    required bool hasBlock,
    required TetrisColors color,
  }) = _PanelModel;
}

typedef Panels = List<List<PanelModel>>;
