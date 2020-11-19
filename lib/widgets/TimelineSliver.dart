import "package:flutter/material.dart";
import '../data_types/Timeslot.dart';

class TimelineSliver extends StatefulWidget {

  const TimelineSliver({Key key, this.timeslot}) : super(key: key);
  final Timeslot timeslot;

  @override
  _TimelineSliverState createState() => _TimelineSliverState();
}

class _TimelineSliverState extends State<TimelineSliver> {
  bool _selected= false;

  void _handleTap() {
    setState(() {
      _selected = !_selected;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap();
      },
      child: AnimatedContainer(
        // TODO change color to be the one of the activity category
        color: widget.timeslot.getColor,
        height: _selected? 150 : 50,
        duration: Duration(milliseconds: 25),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(widget.timeslot.getStartTime.toString()),
                // Empty expanded container to force start and end times to top and bottom
                Expanded(
                    child: (Container())
                ),
                Text(widget.timeslot.getEndTime.toString()),
              ]
            ),
          Expanded(
            child: Center(
              child: Text(widget.timeslot.getActivityName),
        ),
          ),
      ],
      ),
      )
    );
  }
}
