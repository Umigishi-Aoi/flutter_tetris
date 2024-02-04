import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../model/enum/tetris_colors.dart';
import '../tetris_controller.dart';
import 'box_title.dart';
import 'mino.dart';

class KeepMino extends StatelessWidget {
  const KeepMino({super.key});

  @override
  Widget build(BuildContext context) {
    final config = TetrisController.of(context).keepMino;
    final panelSize = getFieldPanelSize(context);
    return Column(
      children: [
        const BoxTitle(title: 'KEEP'),
        Container(
          width: panelSize * infoBoxWidthNumber,
          height: panelSize * infoBoxHeightNumber,
          decoration: BoxDecoration(
            border: Border.all(
              color: TetrisColors.grey.color,
              width: infoBorderWidth,
            ),
            color: TetrisColors.black.color,
          ),
          child: Center(
            child: Builder(
              builder: (context) {
                if (config == null) {
                  return Container();
                }
                return Mino(
                  minoPanel: config.nextMino(),
                  panelSize: panelSize,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
