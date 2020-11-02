import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'gamePlay.dart';
import 'leaderboard.dart';
import 'settings.dart';
import 'store.dart';

class Inst extends StatefulWidget {
  Inst({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InstState createState() => _InstState();
}

class _InstState extends State<Inst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.lightBlue[100]])),
          child: ListTile(
            title: Text(
              "Game Instructions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.left,
            ),
            subtitle: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Game Play',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              '\nAfter selecting the number of patients you would like to see in the session you will be directed to the first round of the game. First you will be given the basic information on the patient, i.e. symptoms, age, etc. You also will be able to click to see more info such as results from tests or xrays. '),
                      TextSpan(
                          text:
                              '\nOnce you see and go through all of the information you would like you may then swip the patient card into the category you believe it goes (COPD, pnnemonia, or CHF). '),
                      TextSpan(
                          text:
                              'The game will tell you whether you are right or wrong and give an explanation as to the correct answer. '),
                      TextSpan(
                          text: 'Click here to play',
                          style: TextStyle(
                              color: Colors.blueAccent[700], fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Game(),
                                  ));
                            }),
                      TextSpan(
                          text: '\n\nExtra Features:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              '\nSettings: There are extra features you may use while playing the game as well. One of which is a settings page. In settings you may turn of sound, change the name the app calls you, or turn off the sabotage feature.'),
                      TextSpan(
                          text: 'Click here to checkout settings',
                          style: TextStyle(
                              color: Colors.blueAccent[700], fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Settings(),
                                  ));
                            }),
                      TextSpan(
                          text:
                              '\n\nCustomizing: There is a shop feature, where after having a certain streak length, or number of correct answers you may customize your doctor avatar and buy personalizable items. '),
                      TextSpan(
                          text: 'Click here to shop',
                          style: TextStyle(
                              color: Colors.blueAccent[700], fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Store(),
                                  ));
                            }),
                      TextSpan(
                          text:
                              '\n\nStats and Leaderboard: Finally there is a page in which you can see your stats for the game. This will include longest correct streak, best diagnosing category, worst diagnosing category, total points, and hours played.'),
                      TextSpan(
                          text:
                              'There is also a leaderboard feature under this tab where you can see how you rank in comparison to friends and collegues.'),
                      TextSpan(
                          text:
                              ' Click here to check out leaderboard and stats',
                          style: TextStyle(
                              color: Colors.blueAccent[700], fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaderBoard(),
                                  ));
                            }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //bottomNavigationBar: navBar(),
    );
  }
}
