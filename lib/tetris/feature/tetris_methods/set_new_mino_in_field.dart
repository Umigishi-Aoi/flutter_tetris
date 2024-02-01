import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';

/// 新しいMinoPanel の設定処理
(bool, Panels) setNewMinoInField({
  required MinoStateModel minoStateModel,
  required Panels fieldState,
}) {
  final position = minoStateModel.position;

  final minoPanels = minoStateModel.panels();

  final newMinoPanelVerticalLength = minoPanels.length;
  final newMinoPanelHorizontalLength = minoPanels[0].length;

  var setSuccess = true;

  var tempIndexX = 0;
  var tempIndexY = 0;

  final tempFieldState = fieldState.indexed.map((indexedY) {
    if (indexedY.$1 < position.y ||
        indexedY.$1 >= position.y + newMinoPanelVerticalLength) {
      return indexedY.$2;
    }
    final panels = indexedY.$2.indexed.map((indexedX) {
      if (indexedX.$1 < position.x ||
          indexedX.$1 >= position.x + newMinoPanelHorizontalLength) {
        return indexedX.$2;
      }
      if (!minoPanels[tempIndexY][tempIndexX].hasBlock) {
        tempIndexX++;
        return indexedX.$2;
      }

      if (indexedX.$2.hasBlock) {
        setSuccess = false;
      }

      final panel = minoPanels[tempIndexY][tempIndexX];

      tempIndexX++;
      return panel;
    }).toList();
    tempIndexX = 0;
    tempIndexY++;
    return panels;
  }).toList();

  return (setSuccess, tempFieldState);
}
