// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graph_calculator_example/controllers/graph_controller.dart';
import 'package:graph_calculator_example/widget/graph_widget.dart';
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
  var graphController = GraphController(graph: Graph(numbersStyle: TextStyle(color: Colors.black)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body:  Center(
        child: Column(
          children: [
           const SizedBox(height: 100,),
            GraphWidget(graphController: graphController,size:  Size(MediaQuery.of(context).size.width,500),),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        setState(() {
        graphController.addConstObject(GraphText(text: 'text', offset: const Offset(0, 0)));
        graphController.backToHome();
        });

      }) ,
    );
  }
}