import '../../configs.dart';
import '../../model/enum/mino_config.dart';
import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import '../../model/position_model.dart';
import 'set_mino.dart';

(bool, Panels?, MinoStateModel?) tSpinSet({
  required MinoStateModel minoStateModel,
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
}) {
  final setResult = setMino(
    minoStateModel: minoStateModel,
    currentMinoStateModel: currentMinoStateModel,
    fieldState: fieldState,
  );

  //通常の回転でセットできる時
  if (setResult.$1) {
    return (setResult.$1, setResult.$2, minoStateModel);
  }

  int minTempPositionX;
  int maxTempPositionX;

  int maxTempPositionY;

  final currentPosition = currentMinoStateModel.position;
  final rotation = minoStateModel.rotation;

  if (currentPosition.x - 1 < 0) {
    minTempPositionX = currentPosition.x;
  } else {
    minTempPositionX = currentPosition.x - 1;
  }

  if (currentPosition.x + 1 >
      horizontalBlockNumber +
          2 -
          MinoConfig.t.getMinoPanel(rotation)[0].length) {
    maxTempPositionX = currentPosition.x;
  } else {
    maxTempPositionX = currentPosition.x + 1;
  }

  if (currentPosition.y + 2 >
      verticalBlockNumber + 1 - MinoConfig.t.getMinoPanel(rotation).length) {
    maxTempPositionY = currentPosition.y + 1;
  } else if (currentPosition.y + 1 >
      verticalBlockNumber + 1 - MinoConfig.t.getMinoPanel(rotation).length) {
    maxTempPositionY = currentPosition.y;
  } else {
    maxTempPositionY = currentPosition.y + 2;
  }
  for (var i = minTempPositionX; i <= maxTempPositionX; i++) {
    for (var j = currentPosition.y; j <= maxTempPositionY; j++) {
      final tempPosition = PositionModel(x: i, y: j);
      if (tempPosition == currentPosition) {
        break;
      }

      final tempMinoStateModel = currentMinoStateModel.copyWith(
        position: tempPosition,
        rotation: rotation,
      );

      final setResult = setMino(
        minoStateModel: tempMinoStateModel,
        currentMinoStateModel: currentMinoStateModel,
        fieldState: fieldState,
      );

      if (setResult.$1) {
        return (setResult.$1, setResult.$2, tempMinoStateModel);
      }
    }
  }
  return (false, null, null);
}
