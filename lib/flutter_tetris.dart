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
  late Panels fieldState;
  PositionModel currentPosition = PositionModel.init();
  MinoConfig currentMino = MinoConfig.getRandomMino();
  Rotation currentRotation = Rotation.r0;
  late Panels currentMinoPanel;

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
    initMino();
  }

  void initMino() {
    currentMino = MinoConfig.getRandomMino();
    currentRotation = Rotation.r0;
    currentMinoPanel = currentMino.getMinoPanel(currentRotation);
    currentPosition = PositionModel.init();
  }

  bool set({required PositionModel position, required Panels minoPanels}) {
    if (!checkPosition(position)) {
      return false;
    }

    final minoPanelVerticalLength = currentMinoPanel.length;
    final minoPanelHorizontalLength = currentMinoPanel[0].length;

    var tempIndexX = 0;
    var tempIndexY = 0;

    var tempFieldState = fieldState;

    // 現在のMinoの削除処理

    tempFieldState = tempFieldState.indexed.map((indexedY) {
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

    // 新しいMinoPanel の設定処理

    final newMinoPanelVerticalLength = minoPanels.length;
    final newMinoPanelHorizontalLength = minoPanels[0].length;

    var setSuccess = true;

    tempIndexX = 0;
    tempIndexY = 0;

    tempFieldState = tempFieldState.indexed.map((indexedY) {
      if (indexedY.$1 < position.y ||
          indexedY.$1 >= position.y + newMinoPanelVerticalLength) {
        return indexedY.$2;
      }
      final panels = indexedY.$2.indexed.map((indexedX) {
        if (indexedX.$1 < position.x ||
            indexedX.$1 >= position.x + newMinoPanelHorizontalLength) {
          return indexedX.$2;
        }
        if (!minoPanels[tempIndexY][tempIndexX].hasBlock) {
          tempIndexX++;
          return indexedX.$2;
        }

        if (indexedX.$2.hasBlock) {
          setSuccess = false;
        }

        final panel = minoPanels[tempIndexY][tempIndexX];

        tempIndexX++;
        return panel;
      }).toList();
      tempIndexX = 0;
      tempIndexY++;
      return panels;
    }).toList();

    if (!setSuccess) {
      return setSuccess;
    }

    setState(() {
      fieldState = tempFieldState;
    });

    return setSuccess;
  }

  void left() {
    final tempPosition = currentPosition.copyWith(x: currentPosition.x - 1);
    if (set(position: tempPosition, minoPanels: currentMinoPanel)) {
      set(position: tempPosition, minoPanels: currentMinoPanel);
      currentPosition = tempPosition;
    }
  }

  void right() {
    final tempPosition = currentPosition.copyWith(x: currentPosition.x + 1);
    if (set(position: tempPosition, minoPanels: currentMinoPanel)) {
      set(position: tempPosition, minoPanels: currentMinoPanel);
      currentPosition = tempPosition;
    }
  }

  void down() {
    final tempPosition = currentPosition.copyWith(y: currentPosition.y + 1);
    if (set(position: tempPosition, minoPanels: currentMinoPanel)) {
      set(position: tempPosition, minoPanels: currentMinoPanel);
      currentPosition = tempPosition;
    }
  }

  void r90() {
    final tempRotation = currentRotation.rotateR90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (set(position: currentPosition, minoPanels: tempPanels)) {
      set(position: currentPosition, minoPanels: tempPanels);
      currentRotation = tempRotation;
      currentMinoPanel = tempPanels;
    }
  }

  void l90() {
    final tempRotation = currentRotation.rotateL90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (set(position: currentPosition, minoPanels: tempPanels)) {
      set(position: currentPosition, minoPanels: tempPanels);
      currentRotation = tempRotation;
      currentMinoPanel = tempPanels;
    }
  }

  bool checkPosition(PositionModel position) {
    if (position.x < 0 || position.x >= horizontalBlockNumber) {
      return false;
    }
    if (position.y < 0 || position.y >= verticalBlockNumber) {
      return false;
    }
    return true;
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
                onPressed: () {
                  init();
                  setState(() {});
                },
                child: const Text('init'),
              ),
              ElevatedButton(
                onPressed: () {
                  initMino();
                  set(
                    position: currentPosition,
                    minoPanels: currentMinoPanel,
                  );
                },
                child: const Text('add'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: left,
                    child: const Text('Left'),
                  ),
                  ElevatedButton(
                    onPressed: right,
                    child: const Text('Right'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: down,
                child: const Text('Down'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: l90,
                    child: const Text('L90'),
                  ),
                  ElevatedButton(
                    onPressed: r90,
                    child: const Text('R90'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
