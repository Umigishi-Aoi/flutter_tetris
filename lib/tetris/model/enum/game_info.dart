enum GameInfo {
  waiting(info: '''Press Enter or Start Button'''),
  gameOver(info: '''Game Over'''),
  playing(info: '');

  const GameInfo({required this.info});

  final String info;
}
