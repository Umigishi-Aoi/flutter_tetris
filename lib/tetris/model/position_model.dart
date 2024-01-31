// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_tetris/tetris/config/configs.dart';

/// →x,↓y
class PositionModel {
  const PositionModel({
    required this.x,
    required this.y,
  });

  factory PositionModel.init() => const PositionModel(
        x: horizontalStartPosition,
        y: verticalStartPosition,
      );

  final int x;
  final int y;

  PositionModel copyWith({
    int? x,
    int? y,
  }) {
    return PositionModel(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      x: map['x'] as int,
      y: map['y'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionModel.fromJson(String source) =>
      PositionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PositionModel(x: $x, y: $y)';

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
