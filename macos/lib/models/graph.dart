import 'package:flutter/material.dart';
import 'package:graph_calculator_example/models/drawable_object.dart';
import 'package:graph_calculator_example/models/graph_offset.dart';

class Graph {
  final double sensibility;
  final TextStyle numbersStyle;
  final Color backgroundColor;
  final Color axesColor;
  final Color gridColor;
  final double gridWidth;
  final double axesWidth;
  final List<DrawableObject> constObjects = [];
  final double gridStep;
  Map<String,GraphOffset> screenlimts ={
    'TopLeft':GraphOffset(0,0),
    'TopRight':GraphOffset(0,0),
    'DownLeft':GraphOffset(0,0),
    'DownRightt':GraphOffset(0,0),
  };
  List<DrawableObject> drawableObjects =[];
   GraphOffset foucesPoint= GraphOffset(0, 0);
  Graph({
    this.gridStep = 100,
    this.sensibility = 0.6,
    this.numbersStyle =
        const TextStyle(color: Colors.white, backgroundColor: Colors.black),
    this.backgroundColor = Colors.black,
    this.axesColor = Colors.white,
    this.gridColor = Colors.grey,
    this.gridWidth = 1.0,
    this.axesWidth = 2.0,
  });
}
