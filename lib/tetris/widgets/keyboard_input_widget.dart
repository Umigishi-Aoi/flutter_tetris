import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../feature/keyboard_input/actions.dart';
import '../feature/keyboard_input/intents.dart';
import '../tetris_controller.dart';

class KeyboardInputWidget extends StatelessWidget {
  const KeyboardInputWidget({
    super.key,
    required this.child,
  });

  final Widget child;

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
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const HardDropIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          StartIntent: StartAction(func: TetrisController.of(context).start),
          RightIntent: RightAction(func: TetrisController.of(context).right),
          LeftIntent: LeftAction(func: TetrisController.of(context).left),
          DownIntent: DownAction(func: TetrisController.of(context).down),
          R90Intent: R90Action(func: TetrisController.of(context).r90),
          L90Intent: L90Action(func: TetrisController.of(context).l90),
          KeepIntent: KeepAction(func: TetrisController.of(context).keep),
          HardDropIntent:
              HardDropAction(func: TetrisController.of(context).hardDrop),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}
