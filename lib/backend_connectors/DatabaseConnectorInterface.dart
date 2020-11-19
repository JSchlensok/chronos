import '../data_types/Activity.dart';
import '../data_types/ActivityCategory.dart';
import '../data_types/Timeslot.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseConnectorInterface {

  Future<Database> get database {}

  void _initDatabase() {}

  Future<void> insertActivity(Activity activity) async {}

  Future<void> insertTimeslot(Timeslot timeslot) async {}

  Future<void> insertActivityCategory(ActivityCategory activityCategory) async {}

  Future<List<Activity>> getActivities() async {}

  Future<List<Timeslot>> getTimeslots(DateTime start, DateTime end) async {}

  Future<List<ActivityCategory>> getActivityCategories() async {}

  Future<void> updateActivity(Activity activity) async {}

  Future<void> updateTimeslot(Timeslot timeslot) async {}

  Future<void> updateActivityCategory(ActivityCategory category) async {}

  Future<void> deleteActivity(Activity activity) async {}

  Future<void> deleteActivityCategory(ActivityCategory category) async {}

  Future<void> deleteTimeslot(Timeslot timeslot) async {}


}