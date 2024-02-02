import 'package:flutter/material.dart';
import '../model/panel_model.dart';

import 'block.dart';

class Mino extends StatelessWidget {
  const Mino({
    super.key,
    required this.minoPanel,
  });

  final Panels minoPanel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: minoPanel
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
