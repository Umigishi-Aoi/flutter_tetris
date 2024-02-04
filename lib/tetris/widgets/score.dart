import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../model/enum/game_info.dart';
import '../model/models.dart';
import '../tetris_controller.dart';
import 'box_title.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    final panelSize = getFieldPanelSize(context);
    return Column(
      children: [
        const BoxTitle(title: 'SCORE'),
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
          child: TetrisController.of(context).isPlaying ||
                  TetrisController.of(context).gameInfo == GameInfo.gameOver
              ? Center(
                  child: Text(
                    TetrisController.of(context).score.toString(),
                    style: TextStyle(
                      color: TetrisColors.white.color,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
