import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/config/rotation.dart';

import '../block/block.dart';

class Mino extends StatelessWidget {
  const Mino({
    super.key,
    required this.config,
    required this.rotation,
  });

  final MinoConfig config;
  final Rotation rotation;

  @override
  Widget build(BuildContext context) {
    final panels = config.getMinoPannel(rotation);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: panels
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
