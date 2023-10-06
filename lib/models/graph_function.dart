import 'dart:ui';

import 'package:graph_calculator_example/models/models.dart';

class GraphFunction {
  Function(double enter) function;
   Paint paint = Paint()
      ..style = PaintingStyle.stroke;
  GraphFunction({required this.function,required Color color}){
    paint.color = color;
  }
  void draw(Canvas canvas, Size size, Graph graph) {
   
    List<Offset> points = [];
    for (double i = -((size.width / 2) - graph.focusPoint.x) / graph.gridStep;
        i < ((size.width / 2) + graph.focusPoint.x) / graph.gridStep;
        i += 0.005) {
      if(!(-function(i) * graph.gridStep).isNaN){
      points.add(Offset(i * graph.gridStep, -function(i) * graph.gridStep));
      }
    }
  
    List<Offset> path = [];
    bool isContinue = false;
    int counter = 1;
    for (var point in points) {
      
      if (point.dy < ((size.height / 2) + graph.focusPoint.y) &&
          point.dy > -((size.height / 2) - graph.focusPoint.y)) {
        if (!isContinue) {
          if (!(counter - 2).isNegative) {
            path.add(points[counter - 2]);
          }
          isContinue = true;
        }
        path.add(point);
        if (counter == points.length) {
          canvas.drawPoints(PointMode.polygon, path, paint);
        }
      } else {
        if (isContinue) {
          path.add(point);
          isContinue = false;
          canvas.drawPoints(PointMode.polygon, path, paint);
          path = [];
        }
      }
      counter++;
    }
  }
}
