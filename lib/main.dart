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
  double sensibility = 0.3;
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
          color: Colors.black,
          height: double.infinity,
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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    double layoutSize = double.maxFinite;
    canvas.translate(size.width / 2 + xAddition, size.height / 2 + yAddition);
    canvas.drawLine(Offset(0, 0), Offset(layoutSize, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(-layoutSize, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, layoutSize), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, -layoutSize), paint);

    void addNumbers() {
      for (int i = 0; i < 200; i += 20) {
        print(i);
        final TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: (i / 20).toInt().toString(),
              style: TextStyle(color: Colors.white),
            ),
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: 5);
        if (i == 0) {
          textPainter.paint(canvas, Offset(i + -10, 2));
        } else {
          textPainter.paint(canvas, Offset(i - 5, 2));
        }
      }
    }

    addNumbers();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
