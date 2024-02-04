import 'dart:async';

import 'package:flutter/material.dart';

import 'configs.dart';
import 'feature/tetris_methods/methods.dart';
import 'model/enum/game_info.dart';
import 'model/models.dart';

class _InheritedTetris extends InheritedWidget {
  const _InheritedTetris({
    required this.data,
    required super.child,
  });

  final TetrisControllerState data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class TetrisController extends StatefulWidget {
  const TetrisController({super.key, required this.child});

  final Widget child;

  static TetrisControllerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedTetris>()!.data;
  }

  @override
  State<TetrisController> createState() => TetrisControllerState();
}

class TetrisControllerState extends State<TetrisController> {
  Panels fieldState = [];
  MinoStateModel currentMinoStateModel = MinoStateModel.init();
  List<MinoConfig> nextMinos = [];
  MinoConfig? keepMino;
  int score = 0;
  bool isTspin = false;
  bool isKept = false;
  GameInfo gameInfo = GameInfo.waiting;
  Timer? timer;

  bool get isPlaying {
    if (timer == null) {
      return false;
    }

    return timer!.isActive;
  }

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
    score = 0;
    isTspin = false;
    isKept = false;
    gameInfo = GameInfo.waiting;
  }

  void left() {
    if (!isPlaying) {
      return;
    }
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
    if (!isPlaying) {
      return;
    }
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
    if (!isPlaying) {
      return;
    }

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
    if (!isPlaying) {
      return;
    }
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
    if (!isPlaying) {
      return;
    }
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
    if (!isPlaying) {
      return;
    }
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
    init();
    timer = Timer.periodic(
      const Duration(
        milliseconds: initialDurationMillisecconds,
      ),
      (timer) => down(),
    );
    gameInfo = GameInfo.playing;
  }

  void stop() {
    if (timer != null && isPlaying) {
      timer!.cancel();
    }
    timer!.cancel();
    gameInfo = GameInfo.gameOver;
  }

  void keep() {
    if (!isPlaying) {
      return;
    }
    if (isKept) {
      return;
    }

    final keepResult = keepMethod(
      currentMinoStateModel: currentMinoStateModel,
      fieldState: fieldState,
      keepMino: keepMino,
      nextMinos: nextMinos,
    );

    if (keepResult.$1) {
      setState(() {
        fieldState = keepResult.$2!;
      });
      if (keepMino != null) {
        final tempMino = keepMino;
        keepMino = currentMinoStateModel.config;
        currentMinoStateModel = currentMinoStateModel.copyWith(
          rotation: Rotation.r0,
          config: tempMino,
        );
      } else {
        keepMino = currentMinoStateModel.config;
        currentMinoStateModel = currentMinoStateModel.copyWith(
          rotation: Rotation.r0,
          config: nextMinos.first,
        );
        nextMinos.removeAt(0);
        nextMinos = setNextMinos(nextMinos: nextMinos);
      }
      isKept = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTetris(
      data: this,
      child: widget.child,
    );
  }
}
