import 'package:flutter_tetris/tetris/config/tetris_colors.dart';

import '../model/panel_model/panel_model.dart';
import 'rotation.dart';

enum MinoConfig {
  i,
  o,
  t,
  s,
  z,
  j,
  l;

  List<List<PanelModel>> getMinoPannel(Rotation r) {
    const n = PanelModel(hasBlock: false, color: TetrisColors.black);
    const pI = PanelModel(hasBlock: true, color: TetrisColors.lightBlue);
    const pO = PanelModel(hasBlock: true, color: TetrisColors.yellow);
    const pT = PanelModel(hasBlock: true, color: TetrisColors.purple);
    const pS = PanelModel(hasBlock: true, color: TetrisColors.green);
    const pZ = PanelModel(hasBlock: true, color: TetrisColors.red);
    const pJ = PanelModel(hasBlock: true, color: TetrisColors.blue);
    const pL = PanelModel(hasBlock: true, color: TetrisColors.orange);

    return switch (this) {
      i => switch (r) {
          Rotation.r0 => [
              [n, n, n, n],
              [pI, pI, pI, pI],
              [n, n, n, n],
              [n, n, n, n],
            ],
          Rotation.r90 => [
              [n, n, pI, n],
              [n, n, pI, n],
              [n, n, pI, n],
              [n, n, pI, n],
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
}
