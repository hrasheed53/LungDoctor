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
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Leaderboard"),
            leading: Icon(Icons.arrow_back),
            bottom: TabBar(
              tabs: [Tab(text: "Leaderboard"), Tab(text: "Stats")],
            )),
        body: TabBarView(
          children: [
            ListView(children: [
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
            ]),
            ListView(children: [
              ListTile(title: Text("Cases Attempted"), subtitle: Text("45")),
              ListTile(title: Text("Correct Diagnoses"), subtitle: Text("35")),
              ListTile(title: Text("Accuracy"), subtitle: Text("78.5%")),
              ListTile(title: Text("Average Score"), subtitle: Text("5865")),
              ListTile(
                  title: Text("Most Misdiagnosed"), subtitle: Text("COPD")),
            ]),
          ],
        ),
        bottomNavigationBar: navBar(),
      ),
    ));
/*
    return Scaffold(
      appBar: new PreferredSize(
        preferredSize: tab.preferredSize,
        child: new Card(
          elevation: 26.0,
          color: Theme.of(context).primaryColor,
          child: tab,
        ),
      ),
      body: ListView(children: [
        ListTile(
            leading: Text('1'), title: Text("User 1"), subtitle: Text("99999")),
        ListTile(
            leading: Text('2'), title: Text("User 2"), subtitle: Text("88888")),
        ListTile(
            leading: Text('3'), title: Text("User 3"), subtitle: Text("77777")),
        ListTile(
            leading: Text('4'), title: Text("User 4"), subtitle: Text("66666")),
        ListTile(
            leading: Text('5'), title: Text("User 5"), subtitle: Text("55555")),
        ListTile(
            leading: Text('6'), title: Text("User 6"), subtitle: Text("44434")),
      ]),
      bottomNavigationBar: navBar(),
    );
    */
  }
}
