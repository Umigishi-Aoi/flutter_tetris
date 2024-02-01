import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/feature/tetris_methods/delete_panels_method.dart';
import 'package:flutter_tetris/tetris/feature/tetris_methods/rotate_r90.dart';
import 'package:flutter_tetris/tetris/feature/tetris_methods/t_spin_set_r90.dart';

import 'configs.dart';
import 'feature/keyboard_input/widgets/keyboard_input_widget.dart';
import 'feature/tetris_methods/get_initial_field.dart';
import 'feature/tetris_methods/hard_drop_loop.dart';
import 'feature/tetris_methods/move_down.dart';
import 'feature/tetris_methods/move_left.dart';
import 'feature/tetris_methods/move_right.dart';
import 'feature/tetris_methods/rotate_l90.dart';
import 'feature/tetris_methods/set_mino.dart';
import 'feature/tetris_methods/set_next_minos.dart';
import 'feature/tetris_methods/t_spin_set_l90.dart';
import 'model/enum/mino_config.dart';
import 'model/enum/rotation.dart';
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
    fieldState = getInitialField();
    nextMinos.clear();
    nextMinos = setNextMinos(nextMinos: nextMinos);
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
    nextMinos = setNextMinos(nextMinos: nextMinos);
  }

  void left() {
    final setResult = moveLeft(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel = currentMinoStateModel.moveLeft();
    }
  }

  void right() {
    final setResult = moveRight(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel = currentMinoStateModel.moveRight();
    }
  }

  void down() {
    final setResult = moveDown(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });
      currentMinoStateModel = currentMinoStateModel.moveDown();
      isTspin = false;
    } else {
      deletePanels();
      isTspin = false;
      isKept = false;
      add();
    }
  }

  void hardDrop() {
    final loopResult = hardDropLoop(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );
    setState(() {
      currentMinoStateModel = loopResult.$1;
      fieldState = loopResult.$2;
    });
    down();
  }

  void r90() {
    final currentMino = currentMinoStateModel.config;

    if (currentMino == MinoConfig.t) {
      final tSpinResult = tSpinSetR90(
        currentMinoStateModel: currentMinoStateModel,
        fieldState: fieldState,
      );

      if (tSpinResult.$1) {
        setState(() {
          fieldState = tSpinResult.$2!;
        });
        currentMinoStateModel = tSpinResult.$3!;
        isTspin = true;
      }
      return;
    }

    final setResult = rotateR90(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });

      currentMinoStateModel = currentMinoStateModel.rotateR90();
    }
  }

  void l90() {
    final currentMino = currentMinoStateModel.config;

    if (currentMino == MinoConfig.t) {
      final tSpinResult = tSpinSetL90(
        currentMinoStateModel: currentMinoStateModel,
        fieldState: fieldState,
      );

      if (tSpinResult.$1) {
        setState(() {
          fieldState = tSpinResult.$2!;
        });
        currentMinoStateModel = tSpinResult.$3!;
        isTspin = true;
      }
      return;
    }

    final setResult = rotateL90(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      setState(() {
        fieldState = setResult.$2!;
      });

      currentMinoStateModel = currentMinoStateModel.rotateL90();
    }
  }

  void add() {
    final nextMinoStateModel = MinoStateModel(
      config: nextMinos.first,
      position: PositionModel.init(),
      rotation: Rotation.r0,
    );

    final setResult = setMino(
      minoStateModel: nextMinoStateModel,
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
    );

    if (setResult.$1) {
      currentMinoStateModel = nextMinoStateModel;

      nextMinos.removeAt(0);

      nextMinos = setNextMinos(nextMinos: nextMinos);
    } else {
      stop();
    }
  }

  void deletePanels() {
    final deletePanelsResult = deletePanelsMethod(fieldState: fieldState);

    score += (deletePanelsResult.$1) *
        (deletePanelsResult.$1) *
        scoreUnit *
        (isTspin ? tspinBonus : 1);

    setState(() {
      fieldState = deletePanelsResult.$2;
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

      final setResult = setMino(
        minoStateModel: minoStateModel,
        currentMinoStateModel: currentMinoStateModel,
        fieldState: fieldState,
        isKeep: true,
      );

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

      final setResult = setMino(
        minoStateModel: minoStateModel,
        currentMinoStateModel: currentMinoStateModel,
        fieldState: fieldState,
        isKeep: true,
      );

      if (setResult.$1) {
        setState(() {
          fieldState = setResult.$2!;
        });
        keepMino = currentMino;
        currentMinoStateModel = minoStateModel;
        nextMinos.removeAt(0);

        nextMinos = setNextMinos(nextMinos: nextMinos);
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