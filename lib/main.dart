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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: MyPainter(),
          child: Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple, onPressed: () {}),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = Colors.deepPurple
    //   ..style = PaintingStyle.stroke;
    // canvas.translate(size.width / 2, size.height / 2);
    // final path = Path()
    //   ..lineTo(double.maxFinite, 0)
    //   ..lineTo(-double.maxFinite, 0)
    //   ..moveTo(0, 0)
    //   ..lineTo(0, double.maxFinite)
    //   ..lineTo(0, double.maxFinite.toDouble() * -1);
    // canvas.drawPath(path, paint);

    var xAddition = 100;
    var yAddition = 100;

    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset((-size.width) - xAddition, (size.height / 2) + yAddition),
        Offset((size.width) + xAddition, (size.height / 2) + yAddition),
        paint);

    // canvas.translate((size.height / 2), (size.height / 2) + yAddition);
    canvas.drawLine(Offset((size.width / 2) - xAddition, 0.0 - yAddition),
        Offset((size.width / 2) - xAddition, (size.height) + yAddition), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
