// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graph_calculator_example/controllers/graph_controller.dart';
import 'package:graph_calculator_example/models/graph_function.dart';
import 'package:graph_calculator_example/widgets/graph_widget.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var graphController = GraphController(
      graph:
          Graph(gridStep: 100, numbersStyle: TextStyle(color: Colors.black)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GraphWidget(
          graphController: graphController,
          size: MediaQuery.of(context).size,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(Icons.line_axis_rounded),
              onPressed: () {
                setState(() {
                  graphController.addFunction(GraphFunction(
                      function: (x) {
                        return 1 / x + 1 / (x - 1);
                      },
                      color: Colors.red));
                });
              }),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(Icons.center_focus_strong),
              onPressed: () {
                setState(() {
                  graphController.backToHome();
                });
              })
        ],
      ),
    );
  }
}
