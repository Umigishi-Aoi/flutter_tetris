import 'package:flutter/material.dart';

import '../model/enum/tetris_colors.dart';
import '../model/panel_model.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.panel,
    required this.panelSize,
  });

  final PanelModel panel;
  final double panelSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: panelSize,
      width: panelSize,
      decoration: BoxDecoration(
        color: panel.color.color,
        border: Border.all(
          color: TetrisColors.black.color,
        ),
      ),
    );
  }
}
