import 'package:flutter/material.dart';

import 'feature/keyboard_input/widgets/keyboard_input_widget.dart';
import 'inherited_widgets/tetris.dart';
import 'widgets/widgets.dart';

class FlutterTetris extends StatelessWidget {
  const FlutterTetris({super.key});

  @override
  Widget build(BuildContext context) {
    return Tetris(
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            return KeyboardInputWidget(
              start: Tetris.of(context).start,
              right: Tetris.of(context).right,
              left: Tetris.of(context).left,
              down: Tetris.of(context).down,
              r90: Tetris.of(context).r90,
              l90: Tetris.of(context).l90,
              keep: Tetris.of(context).keep,
              hardDrop: Tetris.of(context).hardDrop,
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Score(score: Tetris.of(context).score),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KeepMino(config: Tetris.of(context).keepMino),
                            Field(
                              fieldState: Tetris.of(context).fieldState,
                            ),
                            NextMinos(configs: Tetris.of(context).nextMinos),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: Tetris.of(context).start,
                          child: const Text('Start'),
                        ),
                        ElevatedButton(
                          onPressed: Tetris.of(context).keep,
                          child: const Text('Keep'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: Tetris.of(context).left,
                              child: const Text('Left'),
                            ),
                            ElevatedButton(
                              onPressed: Tetris.of(context).right,
                              child: const Text('Right'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: Tetris.of(context).down,
                          child: const Text('Down'),
                        ),
                        ElevatedButton(
                          onPressed: Tetris.of(context).hardDrop,
                          child: const Text('Hard Drop'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: Tetris.of(context).l90,
                              child: const Text('L90'),
                            ),
                            ElevatedButton(
                              onPressed: Tetris.of(context).r90,
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
