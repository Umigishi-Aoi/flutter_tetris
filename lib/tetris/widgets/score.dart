import 'package:flutter/material.dart';

import '../configs.dart';
import '../tetris_controller.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scoreHeight,
      child: Text(TetrisController.of(context).score.toString()),
    );
  }
}
