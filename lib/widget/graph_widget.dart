import 'package:flutter/material.dart';
import 'package:graph_calculator_example/models/graph_offset.dart';

import '../controllers/graph_controller.dart';
import '../models/graph.dart';

class GraphWidget extends StatefulWidget {
  late GraphController _graphController;
   Size size ;
   GraphWidget({super.key,required graphController,this.size = const Size(100,100)}){
    _graphController=  graphController;
  }

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {


  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: widget._graphController.graph.backgroundColor,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            widget._graphController.graph.focusPoint.y -= details.delta.dy * widget._graphController.graph.sensibility;
            widget._graphController.graph.focusPoint.x -= details.delta.dx * widget._graphController.graph.sensibility;
          });
        },
        child: CustomPaint(
          size: widget.size,
          isComplex: true,
          painter: GraphPainter(
             focusPoint: widget._graphController.graph.focusPoint,
              graph: widget._graphController.graph,controller: widget._graphController),
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  GraphOffset focusPoint ;
  final Graph graph;
  final GraphController controller;
   GraphPainter(
      {required this.focusPoint,
      required this.graph,required this.controller});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromPoints(const Offset(0,0), Offset(size.width,size.height)));
        var xAddition=focusPoint.x;
    var yAddition=focusPoint.y;
    canvas.translate(size.width / 2 - xAddition, size.height / 2 - yAddition);
    controller.drawAxes(canvas, size);
    controller.addNumbers(canvas, size);

    controller.drawObjects(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
