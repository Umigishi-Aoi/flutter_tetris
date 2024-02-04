import 'package:flutter/material.dart';

import 'configs.dart';
import 'model/enum/tetris_colors.dart';
import 'tetris_controller.dart';
import 'widgets/controll_info.dart';
import 'widgets/game_info_widget.dart';
import 'widgets/widgets.dart';

class FlutterTetris extends StatelessWidget {
  const FlutterTetris({super.key});

  @override
  Widget build(BuildContext context) {
    return TetrisController(
      child: MaterialApp(
        theme: ThemeData(colorSchemeSeed: TetrisColors.deepBlue.color),
        home: Builder(
          builder: (context) {
            return KeyboardInputWidget(
              child: Scaffold(
                backgroundColor: TetrisColors.deepBlue.color,
                body: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Field(),
                              GameInfoWidget(),
                            ],
                          ),
                          NextMinos(),
                        ],
                      ),
                      ControllInfo(),
                    ],
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
