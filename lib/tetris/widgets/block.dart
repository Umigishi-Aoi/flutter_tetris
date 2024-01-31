import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/enum/tetris_colors.dart';
import '../model/panel_model.dart';

class Block extends StatelessWidget {
  const Block({super.key, required this.panel});

  final PanelModel panel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: panelSize,
      width: panelSize,
      decoration: BoxDecoration(
        color: panel.isTransparent
            ? TetrisColors.transparent.color
            : panel.color.color,
        border: Border.all(
          color: panel.isTransparent
              ? TetrisColors.transparent.color
              : panel.color == TetrisColors.black
                  ? TetrisColors.black.color
                  : TetrisColors.white.color,
        ),
      ),
    );
  }
}
