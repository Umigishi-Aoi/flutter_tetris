import 'dart:math';

import '../panel_model.dart';
import 'rotation.dart';
import 'tetris_colors.dart';

enum MinoConfig {
  i,
  o,
  t,
  s,
  z,
  j,
  l;

  factory MinoConfig.getRandomMino() {
    final random = Random();

    return MinoConfig.values[random.nextInt(MinoConfig.values.length)];
  }

  Panels getMinoPanel(Rotation r) {
    final n = PanelModel(hasBlock: false, color: TetrisColors.transparent);
    final pI = PanelModel(hasBlock: true, color: TetrisColors.lightBlue);
    final pO = PanelModel(hasBlock: true, color: TetrisColors.yellow);
    final pT = PanelModel(hasBlock: true, color: TetrisColors.purple);
    final pS = PanelModel(hasBlock: true, color: TetrisColors.green);
    final pZ = PanelModel(hasBlock: true, color: TetrisColors.red);
    final pJ = PanelModel(hasBlock: true, color: TetrisColors.blue);
    final pL = PanelModel(hasBlock: true, color: TetrisColors.orange);

    return switch (this) {
      i => switch (r) {
          Rotation.r0 => [
              [n, n, n, n],
              [pI, pI, pI, pI],
              [n, n, n, n],
              [n, n, n, n],
            ],
          Rotation.r90 => [
              [n, pI, n, n],
              [n, pI, n, n],
              [n, pI, n, n],
              [n, pI, n, n],
            ],
          Rotation.r180 => [
              [n, n, n, n],
              [n, n, n, n],
              [pI, pI, pI, pI],
              [n, n, n, n],
            ],
          Rotation.r270 => [
              [n, pI, n, n],
              [n, pI, n, n],
              [n, pI, n, n],
              [n, pI, n, n],
            ],
        },
      o => [
          [pO, pO],
          [pO, pO],
        ],
      t => switch (r) {
          Rotation.r0 => [
              [n, pT, n],
              [pT, pT, pT],
              [n, n, n],
            ],
          Rotation.r90 => [
              [n, pT, n],
              [n, pT, pT],
              [n, pT, n],
            ],
          Rotation.r180 => [
              [n, n, n],
              [pT, pT, pT],
              [n, pT, n],
            ],
          Rotation.r270 => [
              [n, pT, n],
              [pT, pT, n],
              [n, pT, n],
            ],
        },
      s => switch (r) {
          Rotation.r0 => [
              [n, pS, pS],
              [pS, pS, n],
              [n, n, n],
            ],
          Rotation.r90 => [
              [n, pS, n],
              [n, pS, pS],
              [n, n, pS],
            ],
          Rotation.r180 => [
              [n, n, n],
              [n, pS, pS],
              [pS, pS, n],
            ],
          Rotation.r270 => [
              [pS, n, n],
              [pS, pS, n],
              [n, pS, n],
            ],
        },
      z => switch (r) {
          Rotation.r0 => [
              [pZ, pZ, n],
              [n, pZ, pZ],
              [n, n, n],
            ],
          Rotation.r90 => [
              [n, n, pZ],
              [n, pZ, pZ],
              [n, pZ, n],
            ],
          Rotation.r180 => [
              [n, n, n],
              [pZ, pZ, n],
              [n, pZ, pZ],
            ],
          Rotation.r270 => [
              [n, pZ, n],
              [pZ, pZ, n],
              [pZ, n, n],
            ],
        },
      j => switch (r) {
          Rotation.r0 => [
              [pJ, n, n],
              [pJ, pJ, pJ],
              [n, n, n],
            ],
          Rotation.r90 => [
              [n, pJ, pJ],
              [n, pJ, n],
              [n, pJ, n],
            ],
          Rotation.r180 => [
              [n, n, n],
              [pJ, pJ, pJ],
              [n, n, pJ],
            ],
          Rotation.r270 => [
              [n, pJ, n],
              [n, pJ, n],
              [pJ, pJ, n],
            ],
        },
      l => switch (r) {
          Rotation.r0 => [
              [n, n, pL],
              [pL, pL, pL],
              [n, n, n],
            ],
          Rotation.r90 => [
              [n, pL, n],
              [n, pL, n],
              [n, pL, pL],
            ],
          Rotation.r180 => [
              [n, n, n],
              [pL, pL, pL],
              [pL, n, n],
            ],
          Rotation.r270 => [
              [pL, pL, n],
              [n, pL, n],
              [n, pL, n],
            ],
        },
    };
  }

  Panels nextMino() {
    final n = PanelModel(hasBlock: false, color: TetrisColors.transparent);
    final pI = PanelModel(hasBlock: true, color: TetrisColors.lightBlue);
    final pO = PanelModel(hasBlock: true, color: TetrisColors.yellow);
    final pT = PanelModel(hasBlock: true, color: TetrisColors.purple);
    final pS = PanelModel(hasBlock: true, color: TetrisColors.green);
    final pZ = PanelModel(hasBlock: true, color: TetrisColors.red);
    final pJ = PanelModel(hasBlock: true, color: TetrisColors.blue);
    final pL = PanelModel(hasBlock: true, color: TetrisColors.orange);

    return switch (this) {
      i => [
          [pI, pI, pI, pI],
        ],
      o => [
          [pO, pO],
          [pO, pO],
        ],
      t => [
          [n, pT, n],
          [pT, pT, pT],
        ],
      s => [
          [n, pS, pS],
          [pS, pS, n],
        ],
      z => [
          [pZ, pZ, n],
          [n, pZ, pZ],
        ],
      j => [
          [pJ, n, n],
          [pJ, pJ, pJ],
        ],
      l => [
          [n, n, pL],
          [pL, pL, pL],
        ],
    };
  }
}
