import 'package:flutter/material.dart';

class TestResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: Text('1'),
              title: Text("White blood cells"),
              subtitle: Text("14.2")),
          ListTile(
              leading: Text('2'),
              title: Text("Hemoglobin"),
              subtitle: Text("13.6")),
          ListTile(
              leading: Text('3'),
              title: Text("Hematocrit"),
              subtitle: Text("40.1")),
          ListTile(
              leading: Text('4'),
              title: Text("Platelets"),
              subtitle: Text("247")),
          ListTile(
              leading: Text('5'), title: Text("Sodium"), subtitle: Text("137")),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
