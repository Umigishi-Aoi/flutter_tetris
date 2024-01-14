import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/config/mino_config.dart';
import 'package:flutter_tetris/tetris/config/rotation.dart';
import 'package:flutter_tetris/tetris/field/field.dart';
import 'package:flutter_tetris/tetris/model/position_model/position_model.dart';
import 'package:flutter_tetris/tetris/next_minos/next_minos.dart';

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
  PositionModel? lastPosition;
  Rotation? lastRotation;
  MinoConfig currentMino = MinoConfig.getRandomMino();
  Rotation currentRotation = Rotation.r0;
  late Panels currentMinoPanel;
  List<MinoConfig> nextMinos = [];
  Timer timer = Timer.periodic(const Duration(seconds: 10000), (timer) {});

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
    nextMinos.clear();
    lastPosition = null;
    lastRotation = null;
    setNextMino();
    initMino();
  }

  void initMino() {
    currentMino = nextMinos.first;
    nextMinos.removeAt(0);
    setNextMino();
    currentRotation = Rotation.r0;
    currentMinoPanel = currentMino.getMinoPanel(currentRotation);
    currentPosition = PositionModel.init();
  }

  void setNextMino() {
    while (nextMinos.length < nextMinoNumber) {
      final temp = MinoConfig.getRandomMino();
      if (nextMinos.isEmpty) {
        nextMinos.add(temp);
      }
      if (nextMinos.last != temp) {
        nextMinos.add(temp);
      }
    }
  }

  bool set({
    required PositionModel position,
    required Rotation rotation,
    required Panels minoPanels,
  }) {
    if (!checkState(
      position,
      rotation,
    )) {
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
    if (set(
      position: tempPosition,
      rotation: currentRotation,
      minoPanels: currentMinoPanel,
    )) {
      set(
        position: tempPosition,
        rotation: currentRotation,
        minoPanels: currentMinoPanel,
      );
      currentPosition = tempPosition;
      lastPosition = currentPosition;
    }
  }

  void right() {
    final tempPosition = currentPosition.copyWith(x: currentPosition.x + 1);
    if (set(
      position: tempPosition,
      rotation: currentRotation,
      minoPanels: currentMinoPanel,
    )) {
      set(
        position: tempPosition,
        rotation: currentRotation,
        minoPanels: currentMinoPanel,
      );
      currentPosition = tempPosition;
      lastPosition = currentPosition;
    }
  }

  void down() {
    final tempPosition = currentPosition.copyWith(y: currentPosition.y + 1);
    if (set(
      position: tempPosition,
      rotation: currentRotation,
      minoPanels: currentMinoPanel,
    )) {
      set(
        position: tempPosition,
        rotation: currentRotation,
        minoPanels: currentMinoPanel,
      );
      currentPosition = tempPosition;
      lastPosition = currentPosition;
    } else {
      deletePanels();
      add();
    }
  }

  void hardDrop() {
    for (var i = 0; i < verticalBlockNumber * 2; i++) {
      final tempPosition = currentPosition.copyWith(y: currentPosition.y + 1);
      if (set(
        position: tempPosition,
        rotation: currentRotation,
        minoPanels: currentMinoPanel,
      )) {
        set(
          position: tempPosition,
          rotation: currentRotation,
          minoPanels: currentMinoPanel,
        );
        currentPosition = tempPosition;
        lastPosition = currentPosition;
      } else {
        break;
      }
    }
    down();
  }

  void r90() {
    final tempRotation = currentRotation.rotateR90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (currentMino == MinoConfig.t) {
      tspinSet(rotation: tempRotation, minoPanels: tempPanels);
      return;
    }

    if (set(
      position: currentPosition,
      rotation: tempRotation,
      minoPanels: tempPanels,
    )) {
      set(
        position: currentPosition,
        rotation: tempRotation,
        minoPanels: tempPanels,
      );
      currentRotation = tempRotation;
      lastPosition = currentPosition;
      lastRotation = currentRotation;
      currentMinoPanel = tempPanels;
    }
  }

  void l90() {
    final tempRotation = currentRotation.rotateL90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (currentMino == MinoConfig.t) {
      tspinSet(rotation: tempRotation, minoPanels: tempPanels);
      return;
    }

    if (set(
      position: currentPosition,
      rotation: tempRotation,
      minoPanels: tempPanels,
    )) {
      set(
        position: currentPosition,
        rotation: tempRotation,
        minoPanels: tempPanels,
      );
      log(currentPosition.toString());
      currentRotation = tempRotation;
      lastPosition = currentPosition;
      lastRotation = currentRotation;
      currentMinoPanel = tempPanels;
    }
  }

  void add() {
    initMino();
    if (set(
      position: currentPosition,
      rotation: currentRotation,
      minoPanels: currentMinoPanel,
    )) {
      set(
        position: currentPosition,
        rotation: currentRotation,
        minoPanels: currentMinoPanel,
      );
      lastPosition = currentPosition;
      lastRotation = currentRotation;
    } else {
      stop();
    }
  }

  bool checkState(PositionModel position, Rotation rotation) {
    if (position.x < 0 || position.x >= horizontalBlockNumber) {
      return false;
    }
    if (position.y < 0 || position.y >= verticalBlockNumber) {
      return false;
    }
    if (lastPosition == position && lastRotation == rotation) {
      return false;
    }
    return true;
  }

  void deletePanels() {
    final canDeleteIndexes = <int>[];

    for (final indexed in fieldState.indexed) {
      var canDelete = true;
      if (indexed.$1 == verticalBlockNumber) {
        canDelete = false;
      }
      for (final panel in indexed.$2) {
        if (!panel.hasBlock) {
          canDelete = false;
        }
      }
      if (canDelete) {
        canDeleteIndexes.add(indexed.$1);
      }
    }

    canDeleteIndexes.forEach(fieldState.removeAt);

    const wall = PanelModel(hasBlock: true, color: TetrisColors.grey);

    final newHorizontalPanel = [
      wall,
      ...List.generate(
        horizontalBlockNumber,
        (index) => const PanelModel(hasBlock: false, color: TetrisColors.black),
      ),
      wall,
    ];

    setState(() {
      fieldState = [
        ...List.generate(
          canDeleteIndexes.length,
          (index) => newHorizontalPanel,
        ),
        ...fieldState,
      ];
    });
  }

  void start() {
    timer.cancel();
    init();
    timer = Timer.periodic(
      const Duration(
        milliseconds: initialDurationMillisecconds,
      ),
      (timer) => down(),
    );
    setState(() {});
  }

  void stop() {
    timer.cancel();
  }

  void setTransparent() {
    fieldState = fieldState.indexed.map((y) {
      if (y.$1 < notShowMinoVerticalNumber) {
        return y.$2.map((x) => x.copyWith(isTransparent: true)).toList();
      }
      return y.$2.map((x) => x.copyWith(isTransparent: false)).toList();
    }).toList();
  }

  void tspinSet({
    required Rotation rotation,
    required Panels minoPanels,
  }) {
    //通常の回転でセットできる時
    if (set(
      position: currentPosition,
      rotation: rotation,
      minoPanels: minoPanels,
    )) {
      set(
        position: currentPosition,
        rotation: rotation,
        minoPanels: minoPanels,
      );
      currentRotation = rotation;
      lastPosition = currentPosition;
      lastRotation = currentRotation;
      currentMinoPanel = minoPanels;
      return;
    }

    int minTempPositionX;
    int maxTempPositionX;

    int maxTempPositionY;

    if (currentPosition.x - 1 < 0) {
      minTempPositionX = currentPosition.x;
    } else {
      minTempPositionX = currentPosition.x - 1;
    }

    if (currentPosition.x + 1 >
        horizontalBlockNumber +
            2 -
            MinoConfig.t.getMinoPanel(rotation)[0].length) {
      maxTempPositionX = currentPosition.x;
    } else {
      maxTempPositionX = currentPosition.x + 1;
    }

    if (currentPosition.y + 2 >
        verticalBlockNumber + 1 - MinoConfig.t.getMinoPanel(rotation).length) {
      maxTempPositionY = currentPosition.y + 1;
    } else if (currentPosition.y + 1 >
        verticalBlockNumber + 1 - MinoConfig.t.getMinoPanel(rotation).length) {
      maxTempPositionY = currentPosition.y;
    } else {
      maxTempPositionY = currentPosition.y + 2;
    }
    for (var i = minTempPositionX; i <= maxTempPositionX; i++) {
      for (var j = currentPosition.y; j <= maxTempPositionY; j++) {
        final tempPosition = PositionModel(x: i, y: j);
        if (tempPosition == currentPosition) {
          break;
        }

        if (set(
          position: tempPosition,
          rotation: rotation,
          minoPanels: minoPanels,
        )) {
          set(
            position: tempPosition,
            rotation: rotation,
            minoPanels: minoPanels,
          );
          currentPosition = tempPosition;
          currentRotation = rotation;
          lastPosition = currentPosition;
          lastRotation = currentRotation;
          currentMinoPanel = minoPanels;
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setTransparent();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Field(
                    fieldState: fieldState,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: panelSize * notShowMinoVerticalNumber,
                      ),
                      NextMinos(configs: nextMinos),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: start,
                child: const Text('Start'),
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
              ElevatedButton(
                onPressed: hardDrop,
                child: const Text('Hard Drop'),
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
