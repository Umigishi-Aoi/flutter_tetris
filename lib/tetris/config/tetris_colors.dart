import 'dart:ui';

enum TetrisColors {
  grey(color: Color(0xff7f7f7f)),
  lightBlue(color: Color(0xff7f7f7f)),
  yellow(color: Color(0xffffff00)),
  purple(color: Color(0xff800080)),
  green(color: Color(0xff00ff00)),
  red(color: Color(0xffff0000)),
  blue(color: Color(0xff0000ff)),
  orange(color: Color(0xffff7f00));

  const TetrisColors({
    required this.color,
  });

  final Color color;
}
