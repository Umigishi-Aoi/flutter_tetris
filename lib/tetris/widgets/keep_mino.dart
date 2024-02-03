import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/enum/tetris_colors.dart';
import '../tetris_controller.dart';
import 'mino.dart';

class KeepMino extends StatelessWidget {
  const KeepMino({super.key});

  @override
  Widget build(BuildContext context) {
    final config = TetrisController.of(context).keepMino;

    return Container(
      width: infoBoxWidth,
      height: keepMinoBoxHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: TetrisColors.grey.color,
          width: infoBorderWidth,
        ),
      ),
      child: Center(
        child: Builder(
          builder: (context) {
            if (config == null) {
              return Container();
            }
            return Mino(
              minoPanel: config.nextMino(),
              panelSize: fieldPanelSize,
            );
          },
        ),
      ),
    );
  }
}
