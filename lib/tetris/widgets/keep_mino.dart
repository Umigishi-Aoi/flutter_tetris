import 'package:flutter/material.dart';

import '../configs.dart';
import '../model/enum/mino_config.dart';
import 'mino.dart';

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
