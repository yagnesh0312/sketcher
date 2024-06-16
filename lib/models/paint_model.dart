import 'package:flutter/material.dart';

class PaintModel {
  Offset? offset;
  double? strokeWidth;
  Color? color;
  bool? isLast;
  DateTime? time;
  PaintModel(
      {this.color, this.offset, this.strokeWidth, this.isLast, this.time});
  PaintModel.fromMap(Map<dynamic, dynamic> map) {
    offset = Offset(map['x'], map['y']);
    time = DateTime.fromMillisecondsSinceEpoch(map['time']);
    strokeWidth = map['strokeWidth'];
    color = Color(map['color']);
    isLast = map['isLast'];
  }
  Map<dynamic, dynamic> toMap() {
    return {
      'x': offset!.dx,
      'y': offset!.dy,
      'strokeWidth': strokeWidth,
      'color': color!.value,
      'isLast': isLast,
      'time': DateTime.now().millisecondsSinceEpoch
    };
  }
}
