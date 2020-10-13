import 'package:RESP2/beginningGame.dart';
import 'package:RESP2/patientCards.dart';
import 'package:RESP2/instructions.dart';
import 'package:flutter/material.dart';
import 'navBar.dart';
import 'package:flutter/src/rendering/box.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.deepOrange[200]])),
        child: ListTile(
              title: Text(
                "How many patients would you like to see in this session?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.left,
              ),
              subtitle: entirePage(),
            )));
  }
  Widget entirePage(){
    return Container(
      child: CustomScrollView(
        slivers: <Widget> [
          SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildListDelegate(
            [Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("1",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("3",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("5",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("7",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("10",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToGame(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("15",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),])
          ),
          SliverList(
          delegate: SliverChildListDelegate([Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                navigateToInstructions(context);
              },
              splashColor: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Instructions",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ),])
          )
        ],
          ),
    );
  }
  Future navigateToInstructions(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Inst()));
  }
  Future navigateToGame(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Patient()));
  }
}