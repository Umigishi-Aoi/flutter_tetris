import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/panel_model.dart';
import 'block.dart';

class Field extends StatelessWidget {
  const Field({required this.fieldState, super.key});

  final Panels fieldState;

  @override
  Widget build(BuildContext context) {
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
                  (panel) => Block(panel: panel),
                )
                .toList(),
          );
        }),
      ],
    );
  }
}
