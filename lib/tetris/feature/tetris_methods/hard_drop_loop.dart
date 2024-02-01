import 'package:flutter_tetris/tetris/feature/tetris_methods/move_down.dart';

import '../../configs.dart';
import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';

(MinoStateModel, Panels) hardDropLoop({
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
}) {
  var tempMinoStateModel = currentMinoStateModel;
  var tempFieldState = fieldState;

  for (var i = 0; i < verticalBlockNumber * 2; i++) {
    final setResult = moveDown(
      currentMinoStateModel: tempMinoStateModel,
      fieldState: tempFieldState,
    );

    if (setResult.$1) {
      tempFieldState = setResult.$2!;

      tempMinoStateModel = tempMinoStateModel.moveDown();
    } else {
      break;
    }
  }

  return (tempMinoStateModel, tempFieldState);
}
