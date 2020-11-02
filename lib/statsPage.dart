import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (ListView(children: [
      ListTile(title: Text("Cases Attempted"), subtitle: Text("45")),
      ListTile(title: Text("Correct Diagnoses"), subtitle: Text("35")),
      ListTile(title: Text("Accuracy"), subtitle: Text("78.5%")),
      ListTile(title: Text("Average Score"), subtitle: Text("5865")),
      ListTile(title: Text("Most Misdiagnosed"), subtitle: Text("COPD")),
    ])));
  }
}
