import 'package:flutter/material.dart';
import 'signIn.dart';
import 'package:RESP2/userData.dart';

// maps category to list of leaderboard entries for that category
Map<String, List<LeaderboardEntry>> leaderboardMap = {};

// maps category to list of people to be displayed for that category
Map<String, List<ListTile>> displayList = {};

// all current categories of the leaderboard, naming has one-to-one
// correspondence to user database naming
List<String> categories = ['storePoints', 'accuracy', 'longestStreak'];

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
        builder: (BuildContext context, AsyncSnapshot<Map<String, num>> data) {
          if (data.hasData) {
            for (int i = 0; i < categories.length; i++) {
              readScores(categories[i]);
              writeScore(data.data[categories[i]].toInt(), categories[i]);
            }
            return DefaultTabController(
                // update length when you add category
                length: 3,
                child: Scaffold(
                  bottomNavigationBar: TabBar(
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.blueGrey,
                    tabs: [
                      // must add Tab item here when you add category
                      Tab(text: 'Store Points'),
                      Tab(text: 'Accuracy'),
                      Tab(text: 'Streak'),
                    ],
                  ),
                  body: TabBarView(children: [
                    for (int i = 0; i < categories.length; i++)
                      if (displayList != null && displayList.isNotEmpty)
                        new ListView(children: displayList[categories[i]])
                      else
                        Text('')
                  ]),
                ));
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

    // only display top 10
    var topTen =
        await leaderboardRef.orderByChild(type).limitToFirst(10).once();
    // avoid error, calling clear on null
    if (leaderboardMap[type] != null) leaderboardMap[type].clear();

    // initialize to avoid null errors
    leaderboardMap[type] = [];
    displayList[type] = [];

    // value is all scores, key is name
    Map m = topTen.value;
    m.forEach((key, value) {
      // don't allow null values to persist, will mess up sorting later
      if (value[type] != null) {
        var entry = LeaderboardEntry(key, value[type]);
        leaderboardMap[type].add(entry);
      }
    });

    // sorts on scores
    leaderboardMap[type].sort((a, b) => b.score.compareTo(a.score));
    // avoid error, calling clear on null
    if (displayList[type] != null) displayList[type].clear();

    for (var i = 0; i < leaderboardMap[type].length; i++) {
      displayList[type].add(ListTile(
          leading: Text((i + 1).toString()),
          title: Text(leaderboardMap[type][i].name),
          subtitle: type == 'accuracy'
              // append a % if it's accuracy percentage
              ? Text('${leaderboardMap[type][i].score.toString()}%')
              : Text(leaderboardMap[type][i].score.toString())));
    }
  }
}
