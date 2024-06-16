import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketcher/models/paint_model.dart';
import 'package:sketcher/pages/home_page.dart';

class Helper {
  static void CreateRoom() async {
    int min = 10000;
    int max = 99999;
    Random rnd = Random();
    int rr = min + rnd.nextInt(max - min);

    var ref = FirebaseDatabase.instance.ref("users/$rr");

// Only update the name, leave the age and address!
    PaintModel pm = PaintModel(
    
        color: Colors.black, isLast: true, offset: Offset.zero, strokeWidth: 1);
    // await ref.set();
    FirebaseDatabase.instance
        .ref()
        .child("users/$rr")
        .push()
        .set(pm.toMap())
        .then((v) {
      Get.to(
        HomePage(id: rr),
         transition: Transition.size,
       duration: const Duration(milliseconds: 600)
      );
    });
  }

  static void addPaint(int id, PaintModel pm) async {
    FirebaseDatabase.instance.ref().child("users/$id").push().set(pm.toMap());
  }

  static fetchData(int id) {}
}
