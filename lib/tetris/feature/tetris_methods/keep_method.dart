import '../../model/enum/mino_config.dart';
import '../../model/enum/rotation.dart';
import '../../model/mino_state_model.dart';
import '../../model/panel_model.dart';
import 'set_mino.dart';

(bool, Panels?) keepMethod({
  required MinoStateModel currentMinoStateModel,
  required Panels fieldState,
  required MinoConfig? keepMino,
  required List<MinoConfig> nextMinos,
}) {
  if (keepMino != null) {
    final minoStateModel = currentMinoStateModel.copyWith(
      rotation: Rotation.r0,
      config: keepMino,
    );

    final setResult = setMino(
      minoStateModel: minoStateModel,
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
      isKeep: true,
    );

    return setResult;
  } else {
    final minoStateModel = currentMinoStateModel.copyWith(
      rotation: Rotation.r0,
      config: nextMinos.first,
    );

    final setResult = setMino(
      minoStateModel: minoStateModel,
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
      isKeep: true,
    );

    return setResult;
  }
}
