import 'package:graph_calculator_example/models/models.dart';
import 'package:flutter/material.dart';

class GraphController {
  final Graph graph;
  GraphController({
    required this.graph,
  });

  void drawAxes(
    Canvas canvas,
    Size size,
    double xAddition,
    double yAddition,
  ) {
    final paint = Paint()
      ..color = graph.axesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = graph.axesWidth;
    canvas.drawLine(Offset(-(size.width / 2 + xAddition.abs()), 0),
        Offset(size.width / 2 + xAddition.abs(), 0), paint);
    canvas.drawLine(Offset(0, -(size.height / 2 + yAddition.abs())),
        Offset(0, size.height / 2 + yAddition.abs()), paint);
  }
}
