import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/models.dart';
import '../tetris_controller.dart';
import 'box_title.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BoxTitle(title: 'SCORE'),
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
          child: Center(
            child: Text(
              TetrisController.of(context).score.toString(),
              style: TextStyle(
                color: TetrisColors.white.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
