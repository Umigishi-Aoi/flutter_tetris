import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/model/panel_model.dart';

import '../block/block.dart';

class Field extends StatelessWidget {
  const Field({required this.fieldState, super.key});

  final Panels fieldState;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...fieldState.map(
          (horizontalPanels) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: horizontalPanels
                .map(
                  (panel) => Block(panel: panel),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
