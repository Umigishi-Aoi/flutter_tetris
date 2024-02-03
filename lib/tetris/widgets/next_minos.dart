import 'package:flutter/material.dart';

import '../tetris_controller.dart';
import 'mino.dart';

class NextMinos extends StatelessWidget {
  const NextMinos({super.key});
  @override
  Widget build(BuildContext context) {
    final configs = TetrisController.of(context).nextMinos;
    return Column(
      children: configs.map((e) => Mino(minoPanel: e.nextMino())).toList(),
    );
  }
}
