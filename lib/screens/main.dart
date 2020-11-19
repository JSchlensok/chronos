import 'package:flutter/material.dart';
import '../widgets/Timeline.dart';
import '../backend_connectors/DatabaseConnector.dart';
import 'dart:async';
import '../data_types/ActivityCategory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseConnector db = DatabaseConnector();
  await db.removeDatabase();
  runApp(TimeTrackingApp());
}

class TimeTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Time Tracking Alpha",
        home: Timeline(),
    );
  }
}
