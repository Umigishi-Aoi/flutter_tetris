import 'package:flutter/material.dart';

import 'intents.dart';

class StartAction extends Action<StartIntent> {
  StartAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(StartIntent intent) {
    func();
    return null;
  }
}

class RightAction extends Action<RightIntent> {
  RightAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(RightIntent intent) {
    func();
    return null;
  }
}

class LeftAction extends Action<LeftIntent> {
  LeftAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(LeftIntent intent) {
    func();
    return null;
  }
}

class DownAction extends Action<DownIntent> {
  DownAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(DownIntent intent) {
    func();
    return null;
  }
}

class R90Action extends Action<R90Intent> {
  R90Action({required this.func});

  final void Function() func;

  @override
  Object? invoke(R90Intent intent) {
    func();
    return null;
  }
}

class L90Action extends Action<L90Intent> {
  L90Action({required this.func});

  final void Function() func;

  @override
  Object? invoke(L90Intent intent) {
    func();
    return null;
  }
}

class KeepAction extends Action<KeepIntent> {
  KeepAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(KeepIntent intent) {
    func();
    return null;
  }
}

class HardDropAction extends Action<HardDropIntent> {
  HardDropAction({required this.func});

  final void Function() func;

  @override
  Object? invoke(HardDropIntent intent) {
    func();
    return null;
  }
}
