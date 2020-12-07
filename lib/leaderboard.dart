import 'package:flutter/material.dart';
import 'signIn.dart';
import 'main.dart';
import 'package:RESP2/userData.dart';

List<LeaderboardEntry> leaderboardList = [];

List<ListTile> displayList = [];

class LeaderboardEntry {
  LeaderboardEntry fromEntry(String n, int s) {
    name = n;
    score = s;
    return this;
  }

  LeaderboardEntry(String name, int score) {
    this.name = name;
    this.score = score;
  }

  String name = '';
  int score = 0;
}

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    readScores();
    return new FutureBuilder(
        future: getStatistics(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> data) {
          //data.data['Nmae']

          if (data.hasData) {
            writeScore(data.data['storePoints'].toInt());
            return Scaffold(
                body: ListView(
                    children: !isAuth //uses default/dummy values if auth fails
                        ? [
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
                          ]
                        : displayList));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future writeScore(int score) async {
    //if (!isAuth) return;
    // ignore: await_only_futures
    await leaderboardRef.child(user.displayName).update({'score': score});
  }

  Future readScores() async {
    // if (!isAuth) return;
    var item =
        await leaderboardRef.orderByChild('score').limitToFirst(10).once();
    leaderboardList.clear();

    Map m = item.value;
    print(m);
    // for (int a = 0; a < m.length;++a){
    //     LeaderboardEntry le;
    //      le.name = key;
    //      le.score = value;
    //      leaderboardList.add(le);

    //  }

    //List<LeaderboardEntry> tmp = [];
    m.forEach((key, value) {
      print(key);
      var le = LeaderboardEntry(key, value['score']);

      leaderboardList.add(le);
    });
    print(leaderboardList[0].name);
    //sorts on scores
    //print(leaderboardList[0].name);
    leaderboardList.sort((a, b) => b.score.compareTo(a.score));
    displayList.clear();

    for (var i = 0; i < leaderboardList.length; i++) {
      print(leaderboardList[i].name);
      print(leaderboardList[i].score.toString());
      displayList.add(ListTile(
          leading: Text((i + 1).toString()),
          title: Text(leaderboardList[i].name),
          subtitle: Text(leaderboardList[i].score.toString())));
    }
  }
}
