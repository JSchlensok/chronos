import 'package:flutter_app/data_types/ActivityCategory.dart';

class Activity {
  int id;
  String name;
  ActivityCategory category;

  Activity({this.name, this.category});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
    };
  }

  String get getName { return this.name; }
  int get getId { return this.id; }
  ActivityCategory get getCategory { return this.category; }
}