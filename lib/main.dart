// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GraphWidget(graph: Graph()),
    );
  }
}

class GraphWidget extends StatefulWidget {
  final Graph graph;
  const GraphWidget({super.key, required this.graph});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  double _xAddition = 0;
  double _yAddition = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _yAddition += details.delta.dy * widget.graph.sensibility;
          _xAddition += details.delta.dx * widget.graph.sensibility;
        });
      },
      child: Container(
        color: widget.graph.backgroundColor,
        child: CustomPaint(
          painter: MyPainter(
              xAddition: _xAddition,
              yAddition: _yAddition,
              graph: widget.graph),
          child: Container(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double _xAddition;
  final double _yAddition;
  final Graph graph;

  const MyPainter(
      {required double xAddition,
      required double yAddition,
      required this.graph})
      : _yAddition = yAddition,
        _xAddition = xAddition;

  void drawAxes(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = graph.axesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = graph.axesWidth;
    canvas.drawLine(Offset(-(size.width / 2 + _xAddition.abs()), 0),
        Offset(size.width / 2 + _xAddition.abs(), 0), paint);
    canvas.drawLine(Offset(0, -(size.height / 2 + _yAddition.abs())),
        Offset(0, size.height / 2 + _yAddition.abs()), paint);
  }

  void writeNumber(int i, Offset offset, Canvas canvas, bool isHorizontal,
      double xAddition, double yAddition, Size size) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: (i).toInt().toString(),
          style: graph.numbersStyle,
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 10, maxWidth: 100);

    if (isHorizontal) {
      canvas.drawLine(
          Offset(offset.dx + 4, -(size.height / 2 + yAddition.abs())),
          Offset(offset.dx + 4, size.height / 2 + yAddition.abs()),
          Paint()
            ..color = graph.gridColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = graph.gridWidth);
    } else {
      canvas.drawLine(
          Offset(-(size.width / 2 + xAddition.abs()), offset.dy + 10),
          Offset((size.width / 2 + xAddition.abs()), offset.dy + 10),
          Paint()
            ..color = graph.gridColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = graph.gridWidth);
    }
    textPainter.paint(
        canvas,
        isHorizontal
            ? Offset(offset.dx, offset.dy + 2)
            : Offset(offset.dx + 10, offset.dy));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 + _xAddition, size.height / 2 + _yAddition);
    drawAxes(canvas, size);

    double xPositiveLength = size.width / 2 - _xAddition;
    double yPositiveLength = (size.height / 2 - _yAddition);

    var counter = 0;
    final double gridStep = graph.gridStep;
    var pointsCountFromBeginning = (xPositiveLength / gridStep).floor();

    // drawing x numbers
    for (double i = 0; i <= size.width; i += gridStep) {
      if ((pointsCountFromBeginning - counter) != 0) {
        writeNumber(
            pointsCountFromBeginning - counter,
            Offset(
                (gridStep * (pointsCountFromBeginning - counter)).toDouble() -
                    4,
                0),
            canvas,
            true,
            _xAddition,
            _yAddition,
            size);
      }
      counter++;
    }
    counter = 0;
    pointsCountFromBeginning = (yPositiveLength / gridStep).floor();
    // drawing y numbers
    for (double i = 0; i <= size.height; i += gridStep) {
      if (pointsCountFromBeginning - counter != 0) {
        writeNumber(
            -(pointsCountFromBeginning - counter),
            Offset(
                0,
                (gridStep * (pointsCountFromBeginning - counter)).toDouble() -
                    9),
            canvas,
            false,
            _xAddition,
            _yAddition,
            size);
      }

      counter++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
