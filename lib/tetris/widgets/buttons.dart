import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../tetris_controller.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getFieldPanelSize(context) * holizontalDisplayBlockNumber,
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: TetrisController.of(context).l90,
                        child: const Column(
                          children: [
                            Text('Z'),
                            Icon(Icons.rotate_left),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: spaceSize * 2,
                      ),
                      ElevatedButton(
                        onPressed: TetrisController.of(context).r90,
                        child: const Column(
                          children: [
                            Text('X'),
                            Icon(Icons.rotate_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spaceSize,
                  ),
                  ElevatedButton(
                    onPressed: TetrisController.of(context).keep,
                    child: const Column(
                      children: [
                        Text('C'),
                        Text('Keep'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: spaceSize),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: TetrisController.of(context).hardDrop,
                    child: const Column(
                      children: [
                        Icon(Icons.arrow_upward),
                        Text('Hard Drop'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: spaceSize,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: TetrisController.of(context).left,
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(
                        width: spaceSize * 2,
                      ),
                      ElevatedButton(
                        onPressed: TetrisController.of(context).right,
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spaceSize,
                  ),
                  ElevatedButton(
                    onPressed: TetrisController.of(context).down,
                    child: const Icon(Icons.arrow_downward),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
