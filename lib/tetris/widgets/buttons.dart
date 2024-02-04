import 'package:flutter/material.dart';

import '../tetris_controller.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: TetrisController.of(context).start,
          child: const Text('Start'),
        ),
        ElevatedButton(
          onPressed: TetrisController.of(context).keep,
          child: const Text('Keep'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: TetrisController.of(context).left,
              child: const Text('Left'),
            ),
            ElevatedButton(
              onPressed: TetrisController.of(context).right,
              child: const Text('Right'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: TetrisController.of(context).down,
          child: const Text('Down'),
        ),
        ElevatedButton(
          onPressed: TetrisController.of(context).hardDrop,
          child: const Text('Hard Drop'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: TetrisController.of(context).l90,
              child: const Text('L90'),
            ),
            ElevatedButton(
              onPressed: TetrisController.of(context).r90,
              child: const Text('R90'),
            ),
          ],
        ),
      ],
    );
  }
}
