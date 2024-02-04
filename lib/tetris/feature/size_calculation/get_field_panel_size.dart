import 'dart:math';

import 'package:flutter/material.dart';

import '../../configs.dart';

double getFieldPanelSize(BuildContext context) {
  final displayWidth = MediaQuery.sizeOf(context).width;
  final displayHeight = MediaQuery.sizeOf(context).height;

  final sizeByWidth = displayWidth / holizontalDisplayBlockNumber;
  final sizeByHeight =
      displayHeight * verticalFieldSizeRatio / holizontalDisplayBlockNumber;

  return min(sizeByWidth, sizeByHeight);
}
