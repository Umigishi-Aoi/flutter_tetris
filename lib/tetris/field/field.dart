import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/configs.dart';
import 'package:flutter_tetris/tetris/config/tetris_colors.dart';
import 'package:flutter_tetris/tetris/model/panel_model/panel_model.dart';

import '../block/block.dart';

class Field extends StatefulWidget {
  const Field({super.key});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  late List<List<PanelModel>> fieldState;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final playField = List.generate(
      verticalBlockNumber,
      (verticalIndex) => List.generate(
        horizontalBlockNumber,
        (horizontalIndex) => const PanelModel(
          hasBlock: false,
          color: TetrisColors.black,
        ),
      ),
    );
    const wall = PanelModel(hasBlock: true, color: TetrisColors.grey);
    final bottomWall = List.generate(
      horizontalBlockNumber,
      (index) => wall,
    );
    final fieldWithBottomWall = [
      ...playField,
      bottomWall,
    ];

    fieldState = fieldWithBottomWall
        .map(
          (horizontalPannels) => [
            wall,
            ...horizontalPannels,
            wall,
          ],
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: fieldState
          .map(
            (horizontalPanels) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: horizontalPanels
                  .map(
                    (panel) => Block(panel: panel),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
