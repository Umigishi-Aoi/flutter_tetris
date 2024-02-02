import '../../model/enum/tetris_colors.dart';
import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';

/// 現在のMinoの削除処理
Panels deleteCurrentMinoFromField({
  required Panels fieldState,
  required MinoStateModel currentMinoStateModel,
}) {
  final currentPosition = currentMinoStateModel.position;
  final currentMinoPanels = currentMinoStateModel.panels();

  final minoPanelVerticalLength = currentMinoPanels.length;
  final minoPanelHorizontalLength = currentMinoPanels[0].length;

  var tempIndexX = 0;
  var tempIndexY = 0;

  return fieldState.indexed.map((indexedY) {
    if (indexedY.$1 < currentPosition.y ||
        indexedY.$1 >= currentPosition.y + minoPanelVerticalLength) {
      return indexedY.$2;
    }
    final panels = indexedY.$2.indexed.map((indexedX) {
      if (indexedX.$1 < currentPosition.x ||
          indexedX.$1 >= currentPosition.x + minoPanelHorizontalLength) {
        return indexedX.$2;
      }
      if (!currentMinoPanels[tempIndexY][tempIndexX].hasBlock) {
        tempIndexX++;
        return indexedX.$2;
      }

      final panel = PanelModel(
        hasBlock: false,
        color: TetrisColors.black,
      );

      tempIndexX++;
      return panel;
    }).toList();
    tempIndexX = 0;
    tempIndexY++;
    return panels;
  }).toList();
}
