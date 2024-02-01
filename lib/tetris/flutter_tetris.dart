import 'dart:async';

import 'package:flutter/material.dart';

import 'configs.dart';
import 'feature/keyboard_input/widgets/keyboard_input_widget.dart';
import 'model/enum/mino_config.dart';
import 'model/enum/rotation.dart';
import 'model/enum/tetris_colors.dart';
import 'model/mino_state_model.dart';
import 'model/panel_model.dart';
import 'model/position_model.dart';
import 'widgets/field.dart';
import 'widgets/keep_mino.dart';
import 'widgets/next_minos.dart';
import 'widgets/score.dart';

class FlutterTetris extends StatefulWidget {
  const FlutterTetris({super.key});

  @override
  State<FlutterTetris> createState() => _FlutterTetrisState();
}

class _FlutterTetrisState extends State<FlutterTetris> {
  late Panels fieldState;
  MinoStateModel currentMinoStateModel = MinoStateModel(
    config: MinoConfig.getRandomMino(),
    position: PositionModel.init(),
    rotation: Rotation.r0,
  );
  List<MinoConfig> nextMinos = [];
  MinoConfig? keepMino;
  Timer timer = Timer.periodic(const Duration(seconds: 10000), (timer) {});
  bool isKept = false;
  int score = 0;
  bool isTspin = false;

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
        (horizontalIndex) => PanelModel(
          hasBlock: false,
          color: TetrisColors.black,
        ),
      ),
    );
    final wall = PanelModel(hasBlock: true, color: TetrisColors.grey);
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
    setNextMino();
    keepMino = null;
    isKept = false;
    score = 0;
    isTspin = false;
    currentMinoStateModel = MinoStateModel(
      config: nextMinos.first,
      position: PositionModel.init(),
      rotation: Rotation.r0,
    );
    nextMinos.removeAt(0);
    setNextMino();
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

  Panels deleteCurrentMinoFromField() {
    final currentPosition = currentMinoStateModel.position;
    final currentMinoPanels = currentMinoStateModel.panels();

    final minoPanelVerticalLength = currentMinoPanels.length;
    final minoPanelHorizontalLength = currentMinoPanels[0].length;

    var tempIndexX = 0;
    var tempIndexY = 0;

    // 現在のMinoの削除処理

    return fieldState.indexed.map((indexedY) {
      if (indexedY.$1 < currentPosition.y ||
          indexedY.$1 >= currentPosition.y + minoPanelVerticalLength) {
        return indexedY.$2;
      }
      final panels = indexedY.$2.indexed.map((indexedX) {
        if (indexedX.$1 < currentPosition.x ||
            indexedX.$1 >= currentPosition.x + minoPanelHorizontalLength) {
          return indexedX.$2;
        }
        if (!currentMinoPanels[tempIndexY][tempIndexX].hasBlock) {
          tempIndexX++;
          return indexedX.$2;
        }

        final panel = PanelModel(
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

  (bool, Panels) setNewMinoInField({
    required MinoStateModel minoStateModel,
    required Panels fieldState,
  }) {
    final position = minoStateModel.position;

    // 新しいMinoPanel の設定処理

    final minoPanels = minoStateModel.panels();

    final newMinoPanelVerticalLength = minoPanels.length;
    final newMinoPanelHorizontalLength = minoPanels[0].length;

    var setSuccess = true;

    var tempIndexX = 0;
    var tempIndexY = 0;

    final tempFieldState = fieldState.indexed.map((indexedY) {
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

    return (setSuccess, tempFieldState);
  }

  (bool, Panels?) set({
    required MinoStateModel minoStateModel,
    bool isKeep = false,
  }) {
    final position = minoStateModel.position;
    final rotation = minoStateModel.rotation;

    final currentPosition = currentMinoStateModel.position;
    final currentRotation = currentMinoStateModel.rotation;

    if (position.x < 0 || position.x >= horizontalBlockNumber) {
      return (false, null);
    }
    if (position.y < 0 || position.y >= verticalBlockNumber) {
      return (false, null);
    }
    if (currentPosition == position && currentRotation == rotation && !isKeep) {
      return (false, null);
    }

    final tempFieldState = deleteCurrentMinoFromField();

    final fieldRecord = setNewMinoInField(
      minoStateModel: minoStateModel,
      fieldState: tempFieldState,
    );

    return fieldRecord;
  }

  void left() {
    final currentPosition = currentMinoStateModel.position;

    final tempPosition = currentPosition.copyWith(x: currentPosition.x - 1);

    final setResult = set(
      minoStateModel: currentMinoStateModel.copyWith(position: tempPosition),
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel =
          currentMinoStateModel.copyWith(position: tempPosition);
    }
  }

  void right() {
    final currentPosition = currentMinoStateModel.position;

    final tempPosition = currentPosition.copyWith(x: currentPosition.x + 1);

    final setResult = set(
      minoStateModel: currentMinoStateModel.copyWith(position: tempPosition),
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel =
          currentMinoStateModel.copyWith(position: tempPosition);
    }
  }

  void down() {
    final currentPosition = currentMinoStateModel.position;

    final tempPosition = currentPosition.copyWith(y: currentPosition.y + 1);

    final setResult = set(
      minoStateModel: currentMinoStateModel.copyWith(position: tempPosition),
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });

      currentMinoStateModel =
          currentMinoStateModel.copyWith(position: tempPosition);
      isTspin = false;
    } else {
      deletePanels();
      isTspin = false;
      isKept = false;
      add();
    }
  }

  void hardDrop() {
    for (var i = 0; i < verticalBlockNumber * 2; i++) {
      final tempPosition = currentMinoStateModel.position
          .copyWith(y: currentMinoStateModel.position.y + 1);

      final minoStateModel =
          currentMinoStateModel.copyWith(position: tempPosition);

      final setResult = set(
        minoStateModel: minoStateModel,
      );

      if (setResult.$1) {
        setState(() {
          fieldState = setResult.$2!;
        });

        currentMinoStateModel = minoStateModel;
      } else {
        break;
      }
    }
    down();
  }

  void r90() {
    final currentRotation = currentMinoStateModel.rotation;
    final currentMino = currentMinoStateModel.config;

    final tempRotation = currentRotation.rotateR90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (currentMino == MinoConfig.t) {
      tspinSet(rotation: tempRotation, minoPanels: tempPanels);
      return;
    }

    final setResult = set(
      minoStateModel: currentMinoStateModel.copyWith(rotation: tempRotation),
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });

      currentMinoStateModel =
          currentMinoStateModel.copyWith(rotation: tempRotation);
    }
  }

  void l90() {
    final currentRotation = currentMinoStateModel.rotation;
    final currentMino = currentMinoStateModel.config;

    final tempRotation = currentRotation.rotateL90();
    final tempPanels = currentMino.getMinoPanel(tempRotation);

    if (currentMino == MinoConfig.t) {
      tspinSet(rotation: tempRotation, minoPanels: tempPanels);
      return;
    }

    final setResult = set(
      minoStateModel: currentMinoStateModel.copyWith(rotation: tempRotation),
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });

      currentMinoStateModel =
          currentMinoStateModel.copyWith(rotation: tempRotation);
    }
  }

  void add() {
    final nextMinoStateModel = MinoStateModel(
      config: nextMinos.first,
      position: PositionModel.init(),
      rotation: Rotation.r0,
    );

    final setResult = set(minoStateModel: nextMinoStateModel);

    if (setResult.$1) {
      currentMinoStateModel = nextMinoStateModel;

      nextMinos.removeAt(0);
      setNextMino();
    } else {
      stop();
    }
  }

  void deletePanels() {
    final canDeleteIndexes = <int>[];

    for (final indexed in fieldState.indexed) {
      var canDelete = true;
      if (indexed.$1 == verticalBlockNumber) {
        break;
      }
      for (final panel in indexed.$2) {
        if (!panel.hasBlock) {
          canDelete = false;
          break;
        }
      }
      if (canDelete) {
        canDeleteIndexes.add(indexed.$1);
      }
    }
    final tempFieldState = fieldState.indexed.toList()
      ..removeWhere((element) => canDeleteIndexes.contains(element.$1));
    fieldState = tempFieldState.map((e) => e.$2).toList();

    final wall = PanelModel(hasBlock: true, color: TetrisColors.grey);

    final newHorizontalPanel = [
      wall,
      ...List.generate(
        horizontalBlockNumber,
        (index) => PanelModel(hasBlock: false, color: TetrisColors.black),
      ),
      wall,
    ];

    score += (canDeleteIndexes.length) *
        (canDeleteIndexes.length) *
        scoreUnit *
        (isTspin ? tspinBonus : 1);

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
    final tempMinoStateModel =
        currentMinoStateModel.copyWith(rotation: rotation);

    final setResult = set(minoStateModel: tempMinoStateModel);

    //通常の回転でセットできる時
    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel =
          currentMinoStateModel.copyWith(rotation: rotation);
      isTspin = true;
      return;
    }

    int minTempPositionX;
    int maxTempPositionX;

    int maxTempPositionY;

    final currentPosition = currentMinoStateModel.position;

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

        final tempMinoStateModel = currentMinoStateModel.copyWith(
          position: tempPosition,
          rotation: rotation,
        );

        final setResult = set(minoStateModel: tempMinoStateModel);

        if (setResult.$1) {
          setState(() {
            fieldState = setResult.$2!;
          });
          currentMinoStateModel = tempMinoStateModel;
          isTspin = true;
          return;
        }
      }
    }
  }

  void keep() {
    final currentMino = currentMinoStateModel.config;

    if (isKept) {
      return;
    }

    if (keepMino != null) {
      final minoStateModel = currentMinoStateModel.copyWith(
        rotation: Rotation.r0,
        config: keepMino,
      );

      final setResult = set(minoStateModel: minoStateModel, isKeep: true);

      if (setResult.$1) {
        setState(() {
          fieldState = setResult.$2!;
        });

        keepMino = currentMino;
        currentMinoStateModel = minoStateModel;
      }
    } else {
      final minoStateModel = currentMinoStateModel.copyWith(
        rotation: Rotation.r0,
        config: nextMinos.first,
      );

      final setResult = set(minoStateModel: minoStateModel, isKeep: true);

      if (setResult.$1) {
        setState(() {
          fieldState = setResult.$2!;
        });
        keepMino = currentMino;
        currentMinoStateModel = minoStateModel;
        nextMinos.removeAt(0);
        setNextMino();
      }
    }

    isKept = true;
  }

  @override
  Widget build(BuildContext context) {
    setTransparent();
    return MaterialApp(
      home: KeyboardInputWidget(
        start: start,
        right: right,
        left: left,
        down: down,
        r90: r90,
        l90: l90,
        keep: keep,
        hardDrop: hardDrop,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Score(score: score),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeepMino(config: keepMino),
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
                ElevatedButton(
                  onPressed: keep,
                  child: const Text('Keep'),
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
      ),
    );
  }
}
