import 'dart:ui';

enum TetrisColors {
  grey(color: Color(0xff7f7f7f)),
  black(color: Color(0xff000000)),
  white(color: Color(0xffffffff)),
  lightBlue(color: Color(0xff00ffff)),
  yellow(color: Color(0xffffff00)),
  purple(color: Color(0xff800080)),
  green(color: Color(0xff00ff00)),
  red(color: Color(0xffff0000)),
  blue(color: Color(0xff0000ff)),
  orange(color: Color(0xffff7f00)),
  transparent(color: Color(0x00000000)),
  deepBlue(color: Color(0xff004b8b));

  const TetrisColors({
    required this.color,
  });

  final Color color;
}
