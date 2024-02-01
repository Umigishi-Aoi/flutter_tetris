import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import 'set_mino.dart';

(bool, Panels?) moveDown({
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
}) {
  final tempModel = currentMinoStateModel.moveDown();

  return setMino(
    minoStateModel: tempModel,
    currentMinoStateModel: currentMinoStateModel,
    fieldState: fieldState,
  );
}
