import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris/field/field.dart';

class FlutterTetris extends StatelessWidget {
  const FlutterTetris({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Field(),
        ),
      ),
    );
  }
}
