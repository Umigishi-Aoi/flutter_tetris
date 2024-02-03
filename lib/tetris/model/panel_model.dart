// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'enum/tetris_colors.dart';

class PanelModel {
  bool hasBlock;
  TetrisColors color;
  PanelModel({
    required this.hasBlock,
    required this.color,
  });

  PanelModel copyWith({
    bool? hasBlock,
    TetrisColors? color,
    bool? isTransparent,
  }) {
    return PanelModel(
      hasBlock: hasBlock ?? this.hasBlock,
      color: color ?? this.color,
    );
  }

  @override
  String toString() => 'PanelModel(hasBlock: $hasBlock, color: $color)';

  @override
  bool operator ==(covariant PanelModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.hasBlock == hasBlock && other.color == color;
  }

  @override
  int get hashCode => hasBlock.hashCode ^ color.hashCode;
}

typedef Panels = List<List<PanelModel>>;
