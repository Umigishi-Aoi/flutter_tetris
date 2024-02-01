// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars

import 'enum/mino_config.dart';
import 'enum/rotation.dart';
import 'panel_model.dart';
import 'position_model.dart';

class MinoStateModel {
  final MinoConfig config;
  final PositionModel position;
  final Rotation rotation;
  MinoStateModel({
    required this.config,
    required this.position,
    required this.rotation,
  });

  Panels panels() {
    return config.getMinoPanel(rotation);
  }

  MinoStateModel copyWith({
    MinoConfig? config,
    PositionModel? position,
    Rotation? rotation,
  }) {
    return MinoStateModel(
      config: config ?? this.config,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
    );
  }

  @override
  String toString() =>
      'MinoStateModel(config: $config, position: $position, rotation: $rotation)';

  @override
  bool operator ==(covariant MinoStateModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.config == config &&
        other.position == position &&
        other.rotation == rotation;
  }

  @override
  int get hashCode => config.hashCode ^ position.hashCode ^ rotation.hashCode;
}
