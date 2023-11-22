import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/config/rotation.dart';
import 'package:flutter_tetris/tetris/field/field.dart';
import 'package:flutter_tetris/tetris/mino/mino.dart';

class FlutterTetris extends StatelessWidget {
  const FlutterTetris({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[
                for (final MinoConfig config in MinoConfig.values)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (final Rotation rotation in Rotation.values)
                        Mino(config: config, rotation: rotation),
                    ],
                  ),
              ],
              const Field(),
            ],
          ),
        ),
      ),
    );
  }
}
