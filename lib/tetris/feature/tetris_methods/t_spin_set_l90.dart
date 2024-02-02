import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import 't_spin_set.dart';

(bool, Panels?, MinoStateModel?) tSpinSetL90({
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
}) {
  final tempModel = currentMinoStateModel.rotateL90();

  return tSpinSet(
    minoStateModel: tempModel,
    currentMinoStateModel: currentMinoStateModel,
    fieldState: fieldState,
  );
}
