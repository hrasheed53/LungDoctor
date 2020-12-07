import 'package:RESP2/patientcard.dart';
import 'package:RESP2/instructions.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int numPatients = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue[100]])),
        child: ListTile(
          title: Text(
            "How many patients would you like to see in this session?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.blue[600]),
            textAlign: TextAlign.center,
          ),
          subtitle: entirePage(),
        ),
      ),
      // bottomNavigationBar: navBar(),
    );
  }

  Widget entirePage() {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              delegate: SliverChildListDelegate([
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("1",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      numPatients = 3;
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("3",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      numPatients = 5;
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("5",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      numPatients = 7;
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("7",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      numPatients = 10;
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("10",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      numPatients = 15;
                      navigateToGame(context);
                    },
                    splashColor: Colors.blue[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("15",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600])),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  navigateToInstructions(context);
                },
                splashColor: Colors.blue[600],
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Instructions",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600])),
                    ],
                  ),
                ),
              ),
            ),
          ]))
        ],
      ),
    );
  }

  Future navigateToInstructions(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Inst()));
  }

  Future navigateToGame(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientCard(
          patientsLeft: numPatients,
        ),
      ),
    );
  }
}
