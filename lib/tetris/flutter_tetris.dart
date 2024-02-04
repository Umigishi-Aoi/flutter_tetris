import 'package:flutter/material.dart';

import 'configs.dart';
import 'model/enum/tetris_colors.dart';
import 'tetris_controller.dart';
import 'widgets/widgets.dart';

class FlutterTetris extends StatelessWidget {
  const FlutterTetris({super.key});

  @override
  Widget build(BuildContext context) {
    return TetrisController(
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            return KeyboardInputWidget(
              child: Scaffold(
                backgroundColor: TetrisColors.deepBlue.color,
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                KeepMino(),
                                SizedBox(
                                  height: spaceHeight,
                                ),
                                Score(),
                              ],
                            ),
                            Field(),
                            NextMinos(),
                          ],
                        ),
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
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
