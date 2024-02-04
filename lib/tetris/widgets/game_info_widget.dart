import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../model/enum/game_info.dart';
import '../model/models.dart';
import '../tetris_controller.dart';

class GameInfoWidget extends StatelessWidget {
  const GameInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameInfo = TetrisController.of(context).gameInfo;
    if (gameInfo == GameInfo.playing) {
      return const SizedBox.shrink();
    }

    return Align(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: getFieldPanelSize(context) * horizontalBlockNumber,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ColoredBox(
                color: TetrisColors.grey.color,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      gameInfo.info,
                      style: TextStyle(
                        color: gameInfo == GameInfo.gameOver
                            ? TetrisColors.red.color
                            : TetrisColors.white.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: spaceSize,
              ),
              ElevatedButton(
                onPressed: TetrisController.of(context).start,
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
