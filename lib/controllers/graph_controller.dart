import 'package:graph_calculator_example/models/drawable_object.dart';
import 'package:graph_calculator_example/models/graph_offset.dart';
import 'package:graph_calculator_example/models/models.dart';
import 'package:flutter/material.dart';

class GraphController {
  final Graph graph;
  GraphController({
    required this.graph,
  });

  void drawAxes(Canvas canvas,Size size,) {
    var xAddition =- graph.foucesPoint.x;
    var yAddition =- graph.foucesPoint.y;
    final paint = Paint()
      ..color = graph.axesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = graph.axesWidth;
    canvas.drawLine(Offset(-(size.width / 2 + xAddition.abs()), 0),
        Offset(size.width / 2 - xAddition, 0), paint);
    canvas.drawLine(Offset(0, -(size.height / 2 + yAddition.abs())),
        Offset(0, size.height / 2 + yAddition.abs()), paint);
  }



  void addObject(DrawableObject object){
graph.drawableObjects.add(object);
  }




  void drawObjects(Canvas canvas,Size size){
    for (var constObject in graph.constObjects) {
      addObject(constObject);
    }
    for (var object in graph.drawableObjects) {
      object.draw(canvas, size);
    }
    graph.drawableObjects = [];
    
  }
  //draw numbers that shown in line



  void addNumbers(Canvas canvas,Size size){
      double xPositiveLength = size.width / 2 + graph.foucesPoint.x;
    double yPositiveLength = (size.height / 2 + graph.foucesPoint.y);

    var counter = 0;
    var pointsCountFromBeginning = (xPositiveLength / graph.gridStep).floor();

    // drawing x numbers
    for (double i = 0; i <= size.width; i += graph.gridStep) {
      var offset =  Offset(
                (graph.gridStep * (pointsCountFromBeginning - counter)).toDouble() -
                    4,
                0);
      if ((pointsCountFromBeginning - counter) != 0) {
        addObject(GraphLine(color: graph.gridColor, startOffset: Offset(offset.dx + 4, -(size.height / 2 + graph.foucesPoint.y.abs())), endOffset: Offset(offset.dx + 4, size.height / 2 + graph.foucesPoint.y.abs()), lineWidth: graph.gridWidth));
        addObject(GraphText(text: (pointsCountFromBeginning - counter).toString(), offset:offset));
      }
      counter++;
    }
    counter = 0;
    pointsCountFromBeginning = (yPositiveLength / graph.gridStep).floor();
    // drawing y numbers
    for (double i = 0; i <= size.height; i += graph.gridStep) {
       var offset =  Offset(
                0,
                (graph.gridStep * (pointsCountFromBeginning - counter)).toDouble() -
                    9);
      if (pointsCountFromBeginning - counter != 0) {
              addObject(GraphLine(color: graph.gridColor, startOffset:  Offset(-(size.width / 2 + graph.foucesPoint.x.abs()), offset.dy + 10), endOffset: Offset((size.width / 2 + graph.foucesPoint.x.abs()), offset.dy + 10), lineWidth: graph.gridWidth));
       addObject(GraphText(text:(-(pointsCountFromBeginning - counter)).toString(),
           offset: offset,));
      }
      counter++;
    }
    
  }
  void backToHome(){
      graph.foucesPoint = GraphOffset(0, 0);
    }
    void addConstObject(DrawableObject object)
    {
      graph.constObjects.add(object);
    }
    
  }
