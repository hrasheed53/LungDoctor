import 'package:flutter/material.dart';
import 'package:RESP2/userData.dart';

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
        builder: (BuildContext context, AsyncSnapshot<Map<String, num>> data) {
          if (data.hasData) {
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
                  subtitle: Text(data.data['accuracy'].toString() + "%")),
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
