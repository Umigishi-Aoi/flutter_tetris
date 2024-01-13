import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/config/rotation.dart';
import 'package:flutter_tetris/tetris/field/field.dart';
import 'package:flutter_tetris/tetris/model/position_model/position_model.dart';

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
  PositionModel currentPosition = PositionModel.init();
  MinoConfig currentMino = MinoConfig.getRandomMino();
  Rotation currentRotation = Rotation.r0;
  late List<List<PanelModel>> currentMinoPanel;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final playField = List.generate(
      verticalBlockNumber + 2,
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
    initMino();
  }

  void initMino() {
    currentMino = MinoConfig.getRandomMino();
    currentRotation = Rotation.r0;
    currentMinoPanel = currentMino.getMinoPanel(currentRotation);
    currentPosition = PositionModel.init();
  }

  void set() {
    removeCurrentMino();
    final minoPanelVerticalLength = currentMinoPanel.length;
    final minoPanelHorizontalLength = currentMinoPanel[0].length;

    var tempIndexX = 0;
    var tempIndexY = 0;

    setState(() {
      fieldState = fieldState.indexed.map((indexedY) {
        if (indexedY.$1 < currentPosition.y ||
            indexedY.$1 >= currentPosition.y + minoPanelVerticalLength) {
          return indexedY.$2;
        }
        final panels = indexedY.$2.indexed.map((indexedX) {
          if (indexedX.$1 < currentPosition.x ||
              indexedX.$1 >= currentPosition.x + minoPanelHorizontalLength) {
            return indexedX.$2;
          }
          if (!currentMinoPanel[tempIndexY][tempIndexX].hasBlock) {
            tempIndexX++;
            return indexedX.$2;
          }

          final panel = currentMinoPanel[tempIndexY][tempIndexX];

          tempIndexX++;
          return panel;
        }).toList();
        tempIndexX = 0;
        tempIndexY++;
        return panels;
      }).toList();
    });
  }

  void removeCurrentMino() {
    final minoPanelVerticalLength = currentMinoPanel.length;
    final minoPanelHorizontalLength = currentMinoPanel[0].length;

    var tempIndexX = 0;
    var tempIndexY = 0;

    fieldState = fieldState.indexed.map((indexedY) {
      if (indexedY.$1 < currentPosition.y ||
          indexedY.$1 >= currentPosition.y + minoPanelVerticalLength) {
        return indexedY.$2;
      }
      final panels = indexedY.$2.indexed.map((indexedX) {
        if (indexedX.$1 < currentPosition.x ||
            indexedX.$1 >= currentPosition.x + minoPanelHorizontalLength) {
          return indexedX.$2;
        }
        if (!currentMinoPanel[tempIndexY][tempIndexX].hasBlock) {
          tempIndexX++;
          return indexedX.$2;
        }

        const panel = PanelModel(
          hasBlock: false,
          color: TetrisColors.black,
        );

        tempIndexX++;
        return panel;
      }).toList();
      tempIndexX = 0;
      tempIndexY++;
      return panels;
    }).toList();
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
                onPressed: set,
                child: const Text('add'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Left'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Right'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Down'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
