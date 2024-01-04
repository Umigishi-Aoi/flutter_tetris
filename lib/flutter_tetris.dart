import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/config/rotation.dart';
import 'package:flutter_tetris/tetris/field/field.dart';

import 'tetris/config/configs.dart';
import 'tetris/config/tetris_colors.dart';
import 'tetris/model/panel_model/panel_model.dart';

class FlutterTetris extends StatefulWidget {
  const FlutterTetris({super.key});

  @override
  State<FlutterTetris> createState() => _FlutterTetrisState();
}

class _FlutterTetrisState extends State<FlutterTetris> {
  late List<List<PanelModel>> fieldState;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final playField = List.generate(
      verticalBlockNumber,
      (verticalIndex) => List.generate(
        horizontalBlockNumber,
        (horizontalIndex) => const PanelModel(
          hasBlock: false,
          color: TetrisColors.black,
        ),
      ),
    );
    const wall = PanelModel(hasBlock: true, color: TetrisColors.grey);
    final bottomWall = List.generate(
      horizontalBlockNumber,
      (index) => wall,
    );
    final fieldWithBottomWall = [
      ...playField,
      bottomWall,
    ];

    fieldState = fieldWithBottomWall
        .map(
          (horizontalPanels) => [
            wall,
            ...horizontalPanels,
            wall,
          ],
        )
        .toList();
  }

  void addMino(MinoConfig config, Rotation rotation) {
    init();
    final minoPanel = config.getMinoPanel(rotation);
    final minoPanelVerticalLength = minoPanel.length;
    final minoPanelHorizontalLength = minoPanel[0].length;

    final horizontalEndPosition =
        horizontalStartPosition + minoPanelHorizontalLength + 1;

    setState(() {
      fieldState = [
        for (int i = 0; i < minoPanelVerticalLength; i++)
          [
            ...List.generate(
              horizontalStartPosition + 1,
              (index) => fieldState[verticalStartPosition + i][index],
            ),
            ...minoPanel[i],
            ...List.generate(
              horizontalBlockNumber - horizontalEndPosition + 2,
              (index) => fieldState[verticalStartPosition + i]
                  [horizontalEndPosition + index],
            ),
          ],
        for (int j = minoPanelVerticalLength; j < verticalBlockNumber + 1; j++)
          fieldState[j],
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Field(
                fieldState: fieldState,
              ),
              ElevatedButton(
                onPressed: () =>
                    addMino(MinoConfig.getRandomMino(), Rotation.r0),
                child: const Text('add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
