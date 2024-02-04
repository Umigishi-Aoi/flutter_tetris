import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../tetris_controller.dart';
import 'block.dart';

class Field extends StatelessWidget {
  const Field({super.key});

  @override
  Widget build(BuildContext context) {
    final fieldState = TetrisController.of(context).fieldState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...fieldState.indexed.map((indexedHorizontalPanels) {
          if (indexedHorizontalPanels.$1 < notShowMinoVerticalNumber) {
            return const SizedBox.shrink();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indexedHorizontalPanels.$2
                .map(
                  (panel) => Block(
                    panel: panel,
                    panelSize: getFieldPanelSize(context),
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }
}
