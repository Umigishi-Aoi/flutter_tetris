import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../settings/actions.dart';
import '../settings/intents.dart';

class KeyboardInputWidget extends StatelessWidget {
  const KeyboardInputWidget({
    super.key,
    required this.child,
    required this.start,
    required this.right,
    required this.left,
    required this.down,
    required this.r90,
    required this.l90,
    required this.keep,
    required this.hardDrop,
  });

  final Widget child;
  final void Function() start;
  final void Function() right;
  final void Function() left;
  final void Function() down;
  final void Function() r90;
  final void Function() l90;
  final void Function() keep;
  final void Function() hardDrop;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.enter): const StartIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const RightIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const LeftIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): const DownIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyX): const R90Intent(),
        LogicalKeySet(LogicalKeyboardKey.keyZ): const L90Intent(),
        LogicalKeySet(LogicalKeyboardKey.keyC): const KeepIntent(),
        LogicalKeySet(LogicalKeyboardKey.space): const HardDropIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          StartIntent: StartAction(func: start),
          RightIntent: RightAction(func: right),
          LeftIntent: LeftAction(func: left),
          DownIntent: DownAction(func: down),
          R90Intent: R90Action(func: r90),
          L90Intent: L90Action(func: l90),
          KeepIntent: KeepAction(func: keep),
          HardDropIntent: HardDropAction(func: hardDrop),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}
