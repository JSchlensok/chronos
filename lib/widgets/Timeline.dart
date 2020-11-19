import 'package:flutter/material.dart';
import 'TimelineSliver.dart';
import '../screens/ChangelogScreen.dart';
import '../data_types/Timeslot.dart';
import '../data_types/Activity.dart';

class Timeline extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Time Tracking Alpha"),
          leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangelogScreen();
                }));
              }),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            expandedHeight: 75.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Date bar'),
            ),
            backgroundColor: Colors.grey,
          ),
          SliverList(delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return TimelineSliver(timeslot: new Timeslot(
                    id: 0,
                    start: new DateTime.now(),
                    end: new DateTime.now(),
                    activity: new Activity(id: 0, name: 'Activity', category: null)
                  )
                );
          }))
        ]));
  }
}
