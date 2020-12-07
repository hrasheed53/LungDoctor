import 'package:flutter/material.dart';
import 'package:RESP2/userData.dart';

double accuracy;

class StatsPage extends StatefulWidget {
  StatsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<String> diseases = ['CHF', 'COPD', 'Pneumonia', 'None yet!'];
  @override

  /* for most correct and incorrect diagnosed:
  0 - CHF
  1 - COPD
  2 - PNUEMONIA
  */
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getStatistics(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> data) {
          if (data.hasData) {
            if (data.data['numAttempted'] == 0) {
              accuracy = 0;
            } else {
              accuracy =
                  (data.data['numCorrect'] / data.data['numAttempted']) * 100;
            }
            return Scaffold(
                body: (ListView(children: [
              ListTile(
                  title: Text("Total Correct"),
                  subtitle: Text(data.data['numCorrect'].toString())),
              ListTile(
                  title: Text("Cases Attempted"),
                  subtitle: Text(data.data['numAttempted'].toString())),
              ListTile(
                  title: Text("Longest Streak"),
                  subtitle: Text(data.data['longestStreak'].toString())),
              ListTile(
                  title: Text("Accuracy"),
                  subtitle: Text(accuracy.toString() + "%")),
              ListTile(
                  title: Text("Most Misdiagnosed"),
                  subtitle: Text(diseases[data.data['mostMisdiagnosed']])),
              ListTile(
                  title: Text("Most Correctly Diagnosed"),
                  subtitle:
                      Text(diseases[data.data['mostCorrectlyDiagnosed']])),
              ListTile(
                  title: Text("Current Points"),
                  subtitle: Text(data.data['storePoints'].toString())),
            ])));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
