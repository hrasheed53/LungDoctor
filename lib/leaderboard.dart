import 'package:flutter/material.dart';
import 'signIn.dart';
import 'package:RESP2/userData.dart';

List<LeaderboardEntry> leaderboardList = [];

List<ListTile> displayList = [];

/* all current categories of the leaderboard, naming has one-to-one 
  correspondence to user database naming */
List<String> categories = ['storePoints', 'accuracy'];

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
    return new FutureBuilder(
        future: getStatistics(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> data) {
          if (data.hasData) {
            for (int i = 0; i < categories.length; i++) {
              readScores(categories[i]);
              writeScore(data.data['storePoints'].toInt(), 'score');
            }
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  bottomNavigationBar: TabBar(
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.blueGrey,
                    tabs: [
                      Tab(text: 'Store Points'),
                      Tab(text: 'Accuracy'),
                    ],
                  ),
                  body: TabBarView(children: [
                    new ListView(children: displayList),
                    Icon(Icons.directions_transit),
                  ])),
            );
            /*return Scaffold(
                body: ListView(
                    children: !isAuth // uses default/dummy values if auth fails
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
                        : displayList));*/
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  /* score is the user's value (accuracy percentage, store points, etc.)
   * type is the category (score for store points, accuracy, etc.)
  */
  Future writeScore(int value, String type) async {
    if (!isAuth) return;
    // probably best to add some check here in the future to make sure database
    // keys don't get created willy nilly
    await leaderboardRef
        .child(user.displayName.replaceAll('.', ''))
        .update({type: value});
  }

  /* reads score from database based on category passed in
  */
  Future readScores(String type) async {
    if (!isAuth) return;
    var item = await leaderboardRef.orderByChild(type).limitToFirst(10).once();
    leaderboardList.clear();

    Map m = item.value;
    print(m);
    m.forEach((key, value) {
      print(key);
      var entry = LeaderboardEntry(key, value[type]);
      leaderboardList.add(entry);
    });
    print(leaderboardList[0].name);
    // sorts on scores
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
