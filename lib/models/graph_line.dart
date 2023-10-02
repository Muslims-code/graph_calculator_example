// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'drawable_object.dart';

class GraphLine extends DrawableObject {
  final Color color;
  final Offset startOffset;
  final Offset endOffset;
  final double lineWidth;
  GraphLine({
    required this.color,
    required this.startOffset,
    required this.endOffset,
    required this.lineWidth,
  });
  


  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(startOffset, endOffset, paint);
  }
  

}
