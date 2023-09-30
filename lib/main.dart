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
  var startPoint = Offset(0, 0);
  var painter = MyPainter(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (d) {
          setState(() {
            startPoint = d.localPosition;
          });
        },
        onHorizontalDragUpdate: (d) {
          setState(() {
            painter.xAddition = startPoint.dx - d.localPosition.dx;
            painter.yAddition = startPoint.dy - d.localPosition.dy;
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: MyPainter(painter.xAddition, painter.yAddition),
            child: Container(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple, onPressed: () {}),
    );
  }
}

class MyPainter extends CustomPainter {
  double xAddition, yAddition;
  MyPainter(this.xAddition, this.yAddition);
  @override
  void paint(Canvas canvas, Size size) {
    print("xAddition: $xAddition, yAddition: $yAddition");
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke;
    double width = size.width;
    double height = size.height;
    xAddition = -xAddition.abs();
    yAddition = -yAddition.abs();
    canvas.drawLine(Offset((-width) - xAddition, (height / 2) + yAddition),
        Offset((width) + xAddition, (height / 2) + yAddition), paint);

    canvas.drawLine(Offset((width / 2) - xAddition, 0.0 - yAddition),
        Offset((width / 2) - xAddition, (height) + yAddition), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
