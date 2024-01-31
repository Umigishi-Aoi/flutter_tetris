import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/widgets/mino.dart';

import '../config/configs.dart';

class KeepMino extends StatelessWidget {
  const KeepMino({required this.config, super.key});

  final MinoConfig? config;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: panelSize * notShowMinoVerticalNumber,
          width: panelSize * 4,
        ),
        if (config != null) Mino(minoPanel: config!.nextMino()),
      ],
    );
  }
}
