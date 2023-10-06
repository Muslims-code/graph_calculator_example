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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            GraphWidget(
              graphController: graphController,
              size: Size(MediaQuery.of(context).size.width, 500),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            setState(() {
              
               graphController.addFunction(GraphFunction(function: (x){
                return 1/x ;
              }, color: Colors.red));
             
              
            });
          }),
    );
  }
}
