// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'drawable_object.dart';

class GraphText extends DrawableObject {
  final String text;
  final TextStyle textStyle;
  final Offset offset;
  GraphText({
    required this.text,
    this.textStyle = const TextStyle(color: Colors.white),
    required this.offset,
  });
  @override
  void draw(Canvas canvas, Size size) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: textStyle,
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 10, maxWidth: 100);
    textPainter.paint(canvas, offset);
  }
}
