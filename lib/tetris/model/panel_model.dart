// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:convert';

import 'package:flutter_tetris/tetris/config/tetris_colors.dart';

class PanelModel {
  bool hasBlock;
  TetrisColors color;
  bool isTransparent = false;
  PanelModel({
    required this.hasBlock,
    required this.color,
    this.isTransparent = false,
  });

  PanelModel copyWith({
    bool? hasBlock,
    TetrisColors? color,
    bool? isTransparent,
  }) {
    return PanelModel(
      hasBlock: hasBlock ?? this.hasBlock,
      color: color ?? this.color,
      isTransparent: isTransparent ?? this.isTransparent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hasBlock': hasBlock,
      'color': color.toMap(),
      'isTransparent': isTransparent,
    };
  }

  factory PanelModel.fromMap(Map<String, dynamic> map) {
    return PanelModel(
      hasBlock: map['hasBlock'] as bool,
      color: TetrisColors.fromMap(map['color'] as Map<String, dynamic>),
      isTransparent: map['isTransparent'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PanelModel.fromJson(String source) =>
      PanelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PanelModel(hasBlock: $hasBlock, color: $color, isTransparent: $isTransparent)';

  @override
  bool operator ==(covariant PanelModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.hasBlock == hasBlock &&
        other.color == color &&
        other.isTransparent == isTransparent;
  }

  @override
  int get hashCode =>
      hasBlock.hashCode ^ color.hashCode ^ isTransparent.hashCode;
}

typedef Panels = List<List<PanelModel>>;
