import 'package:flutter/material.dart';
import 'navBar.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leader Board'),
        ),
        body: ListView(children: [
          ListTile(
              leading: Text('1'),
              title: Text("User 1"),
              subtitle: Text("99999")),
          ListTile(
              leading: Text('2'),
              title: Text("User 2"),
              subtitle: Text("88888")),
          ListTile(
              leading: Text('3'),
              title: Text("User 3"),
              subtitle: Text("77777")),
          ListTile(
              leading: Text('4'),
              title: Text("User 4"),
              subtitle: Text("66666")),
          ListTile(
              leading: Text('5'),
              title: Text("User 5"),
              subtitle: Text("55555")),
          navBar()
        ]));
  }