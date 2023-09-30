import 'dart:async';

import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double xAddition = 0;
  double yAddition = 0;
  double sensibility = 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            yAddition += details.delta.dy * sensibility;
            xAddition += details.delta.dx * sensibility;
          });
        },
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: MyPainter(xAddition: xAddition, yAddition: yAddition),
            child: Container(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            setState(() {
              xAddition = 0;
              yAddition = 0;
            });
          }),
    );
  }
}

class MyPainter extends CustomPainter {
  final double xAddition;
  final double yAddition;
  const MyPainter({required this.xAddition, required this.yAddition});

  void drawAxes(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(
        Offset(0, 0), Offset(size.width + xAddition.abs(), 0), paint);
    canvas.drawLine(
        Offset(0, 0), Offset(-(size.width + xAddition.abs()), 0), paint);
    canvas.drawLine(
        Offset(0, 0), Offset(0, size.height + yAddition.abs()), paint);
    canvas.drawLine(
        Offset(0, 0), Offset(0, -(size.height + yAddition.abs())), paint);
  }

  void writeNumber(int i, Offset offset, Canvas canvas) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: (i).toInt().toString(),
          style: const TextStyle(color: Colors.black),
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 10, maxWidth: 100);
    textPainter.paint(canvas, offset);
    canvas.drawLine(
        Offset(offset.dx + 4, offset.dy + 2),
        Offset(offset.dx + 4, -4),
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 + xAddition, size.height / 2 + yAddition);
    drawAxes(canvas, size);

    void axesLength() {
      double xPositiveLength = size.width / 2 - xAddition;
      double xNegativeLength = size.width / 2 + xAddition;
      double yPositiveLength = size.height / 2 + yAddition;
      double yNegativeLength = size.height / 2 - yAddition;

      print("xPositiveLength: $xPositiveLength");
      print("xNegativeLength: $xNegativeLength");
      print("yPositiveLength: $yPositiveLength");
      print("yNegativeLength: $yNegativeLength");
    }

    double xPositiveLength = size.width / 2 - xAddition;
    print("xPositiveLength: $xPositiveLength");
    if (xPositiveLength / 2 > 1) {
      for (var i = 0; i < size.width; i += 50) {
        var ayism = (size.width / 50).floor();
        writeNumber(
            ayism - i, Offset((50 * (ayism - i)).toDouble(), 0), canvas);
      }
      var fahl = xPositiveLength -
          ((xPositiveLength / size.width).floor() * size.width);
      print("fahl: $fahl");
      // axesLength();
      // for (var i = 1; i < xPositiveLength / 50; i++) {
      //   writeNumber(i, Offset((50 * i).toDouble(), 0), canvas);
      // }
      // writeNumber(2, Offset(100, 0), canvas);
      // writeNumber(3, Offset(150, 0), canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
