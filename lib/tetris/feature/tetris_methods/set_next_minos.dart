import '../../configs.dart';
import '../../model/enum/mino_config.dart';

/// 次のMinoの取得処理
List<MinoConfig> setNextMinos({required List<MinoConfig> nextMinos}) {
  final tempNextMinos = nextMinos;

  while (tempNextMinos.length < nextMinoNumber) {
    final temp = MinoConfig.getRandomMino();
    if (tempNextMinos.isEmpty) {
      tempNextMinos.add(temp);
    }
    if (tempNextMinos.last != temp) {
      tempNextMinos.add(temp);
    }
  }

  return tempNextMinos;
}
