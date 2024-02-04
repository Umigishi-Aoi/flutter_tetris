import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/enum/tetris_colors.dart';
import '../tetris_controller.dart';
import 'box_title.dart';
import 'mino.dart';

class NextMinos extends StatelessWidget {
  const NextMinos({super.key});
  @override
  Widget build(BuildContext context) {
    final configs = TetrisController.of(context).nextMinos;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const BoxTitle(title: 'NEXT'),
            Container(
              width: infoBoxWidth,
              height: keepMinoBoxHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: TetrisColors.grey.color,
                  width: infoBorderWidth,
                ),
                color: TetrisColors.black.color,
              ),
              child: Mino(
                minoPanel: configs.first.nextMino(),
                panelSize: fieldPanelSize,
              ),
            ),
          ],
        ),
        Container(
          width: futureMinoBoxwidth,
          height: futureMinoBoxHeight,
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
              return Mino(minoPanel: e.$2.nextMino(), panelSize: infoPanelSize);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
