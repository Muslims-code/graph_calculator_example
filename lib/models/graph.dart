import 'package:flutter/material.dart';

class Graph {
  final double sensibility;
  final TextStyle numbersStyle;
  final Color backgroundColor;
  final Color axesColor;
  final Color gridColor;
  final double gridWidth;
  final double axesWidth;
  final double gridStep;
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
