import 'package:flutter/material.dart';

import '../configs.dart';
import '../tetris_controller.dart';
import 'mino.dart';

class KeepMino extends StatelessWidget {
  const KeepMino({super.key});

  @override
  Widget build(BuildContext context) {
    final config = TetrisController.of(context).keepMino;

    return SizedBox(
      width: panelSize * 5,
      child: Builder(
        builder: (context) {
          if (config == null) {
            return Container();
          }

          return Mino(minoPanel: config.nextMino());
        },
      ),
    );
  }
}
