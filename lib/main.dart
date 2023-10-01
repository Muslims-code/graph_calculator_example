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
    canvas.drawLine(Offset(-(size.width / 2 + xAddition.abs()), 0),
        Offset(size.width / 2 + xAddition.abs(), 0), paint);
    canvas.drawLine(Offset(0, -(size.height / 2 + yAddition.abs())),
        Offset(0, size.height / 2 + yAddition.abs()), paint);
  }

  void writeNumber(int i, Offset offset, Canvas canvas, bool isHorizontal,
      double xAddition, double yAddition, Size size) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: (i).toInt().toString(),
          style: const TextStyle(
              color: Colors.black, backgroundColor: Colors.white),
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 10, maxWidth: 100);

    if (isHorizontal) {
      canvas.drawLine(
          Offset(offset.dx + 4, -(size.height / 2 + yAddition.abs())),
          Offset(offset.dx + 4, size.height / 2 + yAddition.abs()),
          Paint()
            ..color = Colors.grey
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);
    } else {
      canvas.drawLine(
          Offset(-(size.width / 2 + xAddition.abs()), offset.dy + 10),
          Offset((size.width / 2 + xAddition.abs()), offset.dy + 10),
          Paint()
            ..color = Colors.grey
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);
    }
    textPainter.paint(
        canvas,
        isHorizontal
            ? Offset(offset.dx, offset.dy + 2)
            : Offset(offset.dx + 10, offset.dy));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 + xAddition, size.height / 2 + yAddition);
    drawAxes(canvas, size);

    double xPositiveLength = size.width / 2 - xAddition;
    double yPositiveLength = (size.height / 2 - yAddition);

    var counter = 0;
    var pointsCountFromBeginning = (xPositiveLength / 80).floor();

    // drawing x numbers
    for (var i = 0; i <= size.width; i += 80) {
      if ((pointsCountFromBeginning - counter) != 0) {
        writeNumber(
            pointsCountFromBeginning - counter,
            Offset(
                (80 * (pointsCountFromBeginning - counter)).toDouble() - 4, 0),
            canvas,
            true,
            xAddition,
            yAddition,
            size);
      }
      counter++;
    }
    counter = 0;
    pointsCountFromBeginning = (yPositiveLength / 80).floor();
    // drawing y numbers
    for (var i = 0; i <= size.height; i += 80) {
      if (pointsCountFromBeginning - counter != 0) {
        writeNumber(
            -(pointsCountFromBeginning - counter),
            Offset(
                0, (80 * (pointsCountFromBeginning - counter)).toDouble() - 9),
            canvas,
            false,
            xAddition,
            yAddition,
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
