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
  double sensibility = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            yAddition += details.primaryDelta ?? 0 * sensibility;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            xAddition += details.primaryDelta ?? 0 * sensibility;
          });
        },
        onHorizontalDragStart: (DragStartDetails details) {},
        onHorizontalDragEnd: (DragEndDetails details) {},
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: MyPainter(xAddition: xAddition, yAddition: yAddition),
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
  final double xAddition;
  final double yAddition;
  const MyPainter({required this.xAddition, required this.yAddition});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.translate(size.width / 2 + xAddition, size.height / 2 + yAddition);
    canvas.drawLine(Offset(0, 0), Offset(double.maxFinite, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(-double.maxFinite, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, double.maxFinite), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, -double.maxFinite), paint);
    print(double.maxFinite);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
