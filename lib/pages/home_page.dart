import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketcher/models/helper.dart';
import 'package:sketcher/models/paint_model.dart';

class HomePage extends StatefulWidget {
  final int id;
  const HomePage({super.key, required this.id});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PaintModel> _paintModel = [];
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.black,
    Colors.white,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyanAccent
  ];
  var _currentColor = Colors.black;
  var _strokeWidth = 2.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseDatabase.instance
        .ref()
        .child("users/${widget.id}")
        .onChildAdded
        .listen((d) {
      // Map<String,dynamic> data = d.snapshot.value as Map<String,dynamic>;

      PaintModel pm =
          PaintModel.fromMap(d.snapshot.value as Map<dynamic, dynamic>);
      // print();
      FirebaseDatabase.instance
          .ref("users/${widget.id}/${d.snapshot.key}")
          .remove();
      setState(() {
        _paintModel.add(pm);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAndroid = MediaQuery.of(context).size.width < 1050;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.id.toString()));
              },
              label: Text(
                widget.id.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.copy),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: isAndroid ? Alignment.bottomCenter : Alignment.centerLeft,
        children: [
          GestureDetector(
              onPanStart: (d) {
                Helper.addPaint(
                    widget.id,
                    PaintModel(
                        color: _currentColor,
                        isLast: false,
                        offset: d.localPosition,
                        strokeWidth: _strokeWidth));
                // _paintModel.add(PaintModel(
                //     color: _currentColor,
                //     isLast: false,
                //     offset: d.localPosition,
                //     strokeWidth: _strokeWidth));

                setState(() {});
              },
              onPanUpdate: (d) {
                Helper.addPaint(
                    widget.id,
                    PaintModel(
                        color: _currentColor,
                        isLast: false,
                        offset: d.localPosition,
                        strokeWidth: _strokeWidth));
                // _paintModel.add(PaintModel(
                //     color: _currentColor,
                //     isLast: false,
                //     offset: d.localPosition,
                //     strokeWidth: _strokeWidth));
                setState(() {});
              },
              onPanEnd: (d) {
                Helper.addPaint(
                    widget.id,
                    PaintModel(
                        color: _currentColor,
                        isLast: true,
                        offset: d.localPosition,
                        strokeWidth: _strokeWidth));
                // _paintModel.add(PaintModel(
                //     color: _currentColor,
                //     isLast: true,
                //     offset: d.localPosition,
                //     strokeWidth: _strokeWidth));
                setState(() {});
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: MyPainter(paintModels: _paintModel),
                ),
              )),
          isAndroid
              ? Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-10, 0),
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slider(
                          min: 1.0,
                          max: 100.0,
                          value: _strokeWidth,
                          activeColor: _currentColor,
                          onChanged: (v) {
                            setState(() {
                              _strokeWidth = v;
                            });
                          }),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final color in _colors)
                              GestureDetector(
                                onTap: () {
                                  _currentColor = color;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: _currentColor == color ? 25 : 20,
                                  width: _currentColor == color ? 25 : 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      boxShadow: [
                                        _currentColor == color
                                            ? BoxShadow(
                                                color: color,
                                                blurRadius: 20,
                                              )
                                            : const BoxShadow()
                                      ]),
                                  clipBehavior: Clip.hardEdge,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, -10),
                                              blurStyle: BlurStyle.inner,
                                              blurRadius: 30),
                                        ]),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-10, 0),
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                            min: 1.0,
                            max: 100.0,
                            value: _strokeWidth,
                            onChanged: (v) {
                              setState(() {
                                _strokeWidth = v;
                              });
                            }),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final color in _colors)
                              GestureDetector(
                                onTap: () {
                                  _currentColor = color;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: _currentColor == color ? 25 : 20,
                                  width: _currentColor == color ? 25 : 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      boxShadow: [
                                        _currentColor == color
                                            ? BoxShadow(
                                                color: color,
                                                blurRadius: 20,
                                              )
                                            : const BoxShadow()
                                      ]),
                                  clipBehavior: Clip.hardEdge,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, -10),
                                              blurStyle: BlurStyle.inner,
                                              blurRadius: 30),
                                        ]),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  List<PaintModel> paintModels;
  MyPainter({required this.paintModels});
  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    for (var i = 0; i < paintModels.length - 1; i++) {
      if (paintModels[i].isLast == false &&
          paintModels[i + 1].isLast == false) {
        canvas.drawLine(
            paintModels[i].offset!,
            paintModels[i + 1].offset!,
            Paint()
              ..color = paintModels[i].color!
              ..strokeWidth = paintModels[i].strokeWidth!
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.round);
      } else if (paintModels[i].isLast == false &&
          paintModels[i + 1].isLast == true) {
        canvas.drawPoints(
            PointMode.points,
            [paintModels[i].offset!],
            Paint()
              ..color = paintModels[i].color!
              ..strokeWidth = paintModels[i].strokeWidth!
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.round);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
