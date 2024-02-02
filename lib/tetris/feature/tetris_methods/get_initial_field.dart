import '../../configs.dart';
import '../../model/enum/tetris_colors.dart';
import '../../model/panel_model.dart';

/// 初期状態のFieldStateを取得するメソッド;
Panels getInitialField() {
  final playField = List.generate(
    verticalBlockNumber,
    (verticalIndex) => List.generate(
      horizontalBlockNumber,
      (horizontalIndex) => PanelModel(
        hasBlock: false,
        color: TetrisColors.black,
      ),
    ),
  );
  final wall = PanelModel(hasBlock: true, color: TetrisColors.grey);
  final bottomWall = List.generate(
    horizontalBlockNumber,
    (index) => wall,
  );
  final fieldWithBottomWall = [
    ...playField,
    bottomWall,
  ];

  return fieldWithBottomWall
      .map(
        (horizontalPanels) => [
          wall,
          ...horizontalPanels,
          wall,
        ],
      )
      .toList();
}
