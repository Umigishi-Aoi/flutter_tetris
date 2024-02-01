import '../../configs.dart';
import '../../model/enum/tetris_colors.dart';
import '../../model/panel_model.dart';

(int, Panels) deletePanelsMethod({
  required Panels fieldState,
}) {
  final canDeleteIndexes = <int>[];

  for (final indexed in fieldState.indexed) {
    var canDelete = true;
    if (indexed.$1 == verticalBlockNumber) {
      break;
    }
    for (final panel in indexed.$2) {
      if (!panel.hasBlock) {
        canDelete = false;
        break;
      }
    }
    if (canDelete) {
      canDeleteIndexes.add(indexed.$1);
    }
  }
  final tempFieldStateIndexed = fieldState.indexed.toList()
    ..removeWhere((element) => canDeleteIndexes.contains(element.$1));
  final tempFieldState = tempFieldStateIndexed.map((e) => e.$2).toList();

  final wall = PanelModel(hasBlock: true, color: TetrisColors.grey);

  final newHorizontalPanel = [
    wall,
    ...List.generate(
      horizontalBlockNumber,
      (index) => PanelModel(hasBlock: false, color: TetrisColors.black),
    ),
    wall,
  ];

  final resultState = [
    ...List.generate(
      canDeleteIndexes.length,
      (index) => newHorizontalPanel,
    ),
    ...tempFieldState,
  ];

  return (canDeleteIndexes.length, resultState);
}
