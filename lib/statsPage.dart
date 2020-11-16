import 'package:flutter/material.dart';
import 'package:RESP2/userData.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getStatistics(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> data) {
          return Scaffold(
              body: (ListView(children: [
            ListTile(
                title: Text("Total correct"),
                subtitle: Text(data.data['numCorrect'].toString())),
            ListTile(
                title: Text("Cases attempted"),
                subtitle: Text(data.data['attempted'].toString())),
            /*ListTile(
                title: Text("Accuracy"),
                subtitle: Text(
                    (data.data['attempted'] / data.data['numCorrect'])
                        .toString())),*/
            ListTile(
                title: Text("Longest streak"),
                subtitle: Text(data.data['longestStreak'].toString())),
            ListTile(
                title: Text("Most misdiagnosed"),
                subtitle: Text(data.data['misdiagnosed'].toString())),
            ListTile(
                title: Text("Current points"),
                subtitle: Text(data.data['storePoints'].toString())),
          ])));
        });
  }
}
