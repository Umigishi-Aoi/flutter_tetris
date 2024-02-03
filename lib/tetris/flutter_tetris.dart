import 'package:flutter/material.dart';

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
              start: TetrisController.of(context).start,
              right: TetrisController.of(context).right,
              left: TetrisController.of(context).left,
              down: TetrisController.of(context).down,
              r90: TetrisController.of(context).r90,
              l90: TetrisController.of(context).l90,
              keep: TetrisController.of(context).keep,
              hardDrop: TetrisController.of(context).hardDrop,
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Score(score: TetrisController.of(context).score),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KeepMino(
                                config: TetrisController.of(context).keepMino),
                            Field(
                              fieldState:
                                  TetrisController.of(context).fieldState,
                            ),
                            NextMinos(
                                configs:
                                    TetrisController.of(context).nextMinos),
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
