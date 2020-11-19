import 'package:flutter/material.dart';

class ChangelogScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changelog'),
        leading:
          IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back to home',
            onPressed: () {
              Navigator.pop(
                context
              );
            }
          )
      ),
      body: Column(
        children: [
          Text('Just a test page for now')
        ]
      )
    );
  }
}