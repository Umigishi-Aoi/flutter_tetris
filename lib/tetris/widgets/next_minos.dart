import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../feature/size_calculation/get_future_mino_size.dart';
import '../model/enum/tetris_colors.dart';
import '../tetris_controller.dart';
import 'box_title.dart';
import 'mino.dart';

class NextMinos extends StatelessWidget {
  const NextMinos({super.key});
  @override
  Widget build(BuildContext context) {
    final configs = TetrisController.of(context).nextMinos;

    final panelSize = getFieldPanelSize(context);
    final futurePanelSize = getFutureMinoSize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const BoxTitle(title: 'NEXT'),
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
              child: TetrisController.of(context).isPlaying
                  ? Mino(
                      minoPanel: configs.first.nextMino(),
                      panelSize: panelSize,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(
          height: spaceSize,
        ),
        Container(
          width: futurePanelSize * futureMinoBoxWidthNumber,
          height: futurePanelSize * futureMinoBoxHeightNumber,
          decoration: BoxDecoration(
            border: Border.all(
              color: TetrisColors.grey.color,
              width: infoBorderWidth,
            ),
            color: TetrisColors.black.color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: configs.indexed.map((e) {
              if (e.$1 == 0) {
                return const SizedBox.shrink();
              }
              return TetrisController.of(context).isPlaying
                  ? Mino(
                      minoPanel: e.$2.nextMino(),
                      panelSize: futurePanelSize,
                    )
                  : const SizedBox.shrink();
            }).toList(),
          ),
        ),
      ],
    );
  }
}
