import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/tetris_colors.dart';

import '../model/panel_model/panel_model.dart';

class Block extends StatelessWidget {
  const Block({super.key, required this.panel});

  final PanelModel panel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: panel.color.color,
        border: Border.all(
          color: panel.color == TetrisColors.black
              ? TetrisColors.black.color
              : TetrisColors.white.color,
        ),
      ),
    );
  }
}
