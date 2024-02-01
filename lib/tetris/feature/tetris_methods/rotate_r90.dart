import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import 'set_mino.dart';

/// R90 の回転に対するメソッド。
(bool, Panels?) rotateR90({
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
}) {
  final tempModel = currentMinoStateModel.rotateR90();

  final setMinoResult = setMino(
    minoStateModel: tempModel,
    currentMinoStateModel: currentMinoStateModel,
    fieldState: fieldState,
  );

  return setMinoResult;
}
