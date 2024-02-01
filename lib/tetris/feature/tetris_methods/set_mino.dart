import '../../configs.dart';
import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import 'delete_current_mino_from_field.dart';
import 'set_new_mino_in_field.dart';

(bool, Panels?) setMino({
  required MinoStateModel minoStateModel,
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
  bool isKeep = false,
}) {
  final position = minoStateModel.position;
  final rotation = minoStateModel.rotation;

  final currentPosition = currentMinoStateModel.position;
  final currentRotation = currentMinoStateModel.rotation;

  if (position.x < 0 || position.x >= horizontalBlockNumber) {
    return (false, null);
  }
  if (position.y < 0 || position.y >= verticalBlockNumber) {
    return (false, null);
  }
  if (currentPosition == position && currentRotation == rotation && !isKeep) {
    return (false, null);
  }

  final tempFieldState = deleteCurrentMinoFromField(
    fieldState: fieldState,
    currentMinoStateModel: currentMinoStateModel,
  );

  final fieldRecord = setNewMinoInField(
    minoStateModel: minoStateModel,
    fieldState: tempFieldState,
  );

  return fieldRecord;
}
