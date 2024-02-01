import 'package:flutter/material.dart';

import '../model/enum/mino_config.dart';
import 'mino.dart';

class NextMinos extends StatelessWidget {
  const NextMinos({required this.configs, super.key});

  final List<MinoConfig> configs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: configs.map((e) => Mino(minoPanel: e.nextMino())).toList(),
    );
  }
}
