// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../configs.dart';

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
