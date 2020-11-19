import 'Activity.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Timeslot {
  int id;
  DateTime start;
  DateTime end;
  Activity activity;

  Timeslot({this.id, this.start, this.end, this.activity});

  int get getId { return this.id; }
  DateTime get getStartTime { return this.start; }
  DateTime get getEndTime { return this.end; }
  String get getActivityName { return this.activity.getName; }

  Color get getColor {
    // TODO return color of parent category
    // return this.activity.getCategory().getColor()
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'activity': activity,
    };
  }

}