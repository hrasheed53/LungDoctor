import 'package:RESP2/userData.dart';
import 'package:flutter/material.dart';
import 'package:RESP2/patientcard.dart';
import 'package:RESP2/presentation/my_flutter_app_icons.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

AudioCache cache = new AudioCache();

String hatImage = '';

class Diagnose extends StatefulWidget {
  Diagnose(
      {Key key,
      @required this.patientsLeft,
      this.difficulty,
      this.answer,
      this.rH,
      this.eA})
      : super(key: key);
  final int patientsLeft;
  final String answer;
  final String difficulty;
  final String rH;
  final String eA;
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  int remaining;
  // variables needed from db: correct answer, difficulty, red herring, expert advice
  String ans = "CHF";
  bool correct = false;
  bool lastPatient = false;
  bool changeAnswer = false;
  String redHerring;
  String expertAdvice;
  String difficultyLevel = "easy";
  var randint = Random();

  @override
  Widget build(BuildContext context) {
    remaining = widget.patientsLeft;
    ans = widget.answer;
    difficultyLevel = widget.difficulty;
    redHerring = widget.rH;
    expertAdvice = widget.eA;

    if (remaining == 0) {
      lastPatient = true;
    }

    if (widget.answer == "Heart failure") {
      ans = "CHF";
    } else if (widget.answer == "Pneumonia") {
      ans = "PNEUMONIA";
    }

    //==============================================================================
    //                Button to be dragged:
    //==============================================================================
    Widget draggableButton = Draggable<String>(
      data: ans,
      child: _buildDiagnoseButton(
          const Color(0xffe34646), Icons.local_pharmacy, 'Drag Me To Diagnose'),
      feedback: _buildDiagnoseButton(
          const Color(0xffe34646), Icons.local_pharmacy, 'Drag Me To Diagnose'),
      childWhenDragging: Container(
        width: 110,
        height: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
    //==============================================================================

    //==============================================================================
    //               Build target for button:
    //==============================================================================
    Widget _targetBox(IconData icon, String disease) {
      return new FutureBuilder(
          future: settings(),
          builder:
              (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
            return Material(
              child: DragTarget<String>(
                builder: (context, List<String> incoming, List rejected) {
                  return _buildButton(const Color(0xff2398f7), icon, disease);
                },
                //onWillAccept: (data) => data == disease,
                onAccept: (data) {
                  //NEED TO CALL UPDATESTATISTICS() FUNCTION HERE W/ CORRECT DIAGNOSIS, RIGHT/WRONG, AND DIFFICULTY!!!!!!!
                  print("UPDATESTATSCALL");
                  updateStatistics(data, difficultyLevel, data == disease);
                  //sabotage logic, for now its a 1 in 3 chance he shows up
                  bool sabotage;
                  if (changeAnswer) {
                    sabotage = false;
                  } else {
                    sabotage = randint.nextInt(2) == 0;
                  }

                  //for logic in case they change answer, doesnt get updated unless sabo shows up

                  //Emma and Lea do that thing here
                  //if sabotage_setting = OFF{sabotage = false}
                  if (snapshot.hasData) {
                    if (snapshot.data['sabotageSetting'] == 1 && sabotage) {
                      //and a 1 in 3 chance he is giving good advice
                      bool sabotageCorrect = randint.nextInt(2) == 0;
                      if (snapshot.data['soundSetting'] == 1) {
                        cache.play("sabo.mp3");
                      }
                      correct = true;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/sabotage_man.png',
                                    fit: BoxFit.cover,
                                    scale: 4.5,
                                  ),
                                  Text(
                                      'WAIT! Before you answer, your "friendly" neighborhood doctor has some advice for you:'),
                                  Padding(padding: EdgeInsets.only(top: 6)),
                                  Text(
                                      sabotageCorrect
                                          ? expertAdvice
                                          : redHerring,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic))
                                ],
                              ),
                            ),
                            actions: <Widget>[
//============================================DONT WORRY ABOUT IT====================================================
                              //yea should make that a function or something to not repeat code but here we are
                              TextButton(
                                child: Text('Keep Answer'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (data == disease) {
                                    //-------IF THEY GOT IT RIGHT!!!---------------------------------
                                    correct = true;
                                    if (snapshot.data['soundSetting'] == 1) {
                                      cache.play("correct.mp3");
                                    }
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return new FutureBuilder(
                                            future: getCustomizations(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        Map<String, dynamic>>
                                                    data) {
                                              return AlertDialog(
                                                //Show correct doctor man in a widget here ?
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text('CORRECT!'),
                                                      Stack(children: <Widget>[
                                                        if (data.hasData)
                                                          if (data.data[
                                                                      "labCoatColor"]
                                                                  .toString() ==
                                                              "none")
                                                            Image.asset(
                                                              'assets/images/alien.png',
                                                              fit: BoxFit.cover,
                                                              scale: 4.5,
                                                            ),
                                                        if (data.data[
                                                                    "labCoatColor"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data[
                                                                    "labCoatColor"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data[
                                                                    "background"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data[
                                                                    "background"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data[
                                                                    "hatAccessory"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data[
                                                                    "hatAccessory"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data[
                                                                    "headband"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data[
                                                                    "headband"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data["mask"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data["mask"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data["pet"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data["pet"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          ),
                                                        if (data.data[
                                                                    "stethoscope"]
                                                                .toString() !=
                                                            "none")
                                                          Image.asset(
                                                            data.data[
                                                                    "stethoscope"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            scale: 4.5,
                                                          )
                                                      ]),
                                                      Text(
                                                          "Correct answer was ${widget.answer}.",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5)),
                                                      Text(expertAdvice),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Proceed'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      //this is where it either sends them to next patient
                                                      //or back to main gameplay screen
                                                      if (lastPatient) {
                                                        navigateToGameplay(
                                                            context);
                                                      } else {
                                                        navigateBackToGame(
                                                            context);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                  } else {
                                    //------------IF THEY GOT IT WRONG!!!-------------------------------
                                    if (snapshot.data['soundSetting'] == 1) {
                                      cache.play("incorrect.mp3");
                                    }
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          //Show incorrect doctor man in a widget here ?
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text('INCORRECT'),
                                                Stack(children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/alien_incorrect.png',
                                                    fit: BoxFit.cover,
                                                    scale: 4.5,
                                                  ),
                                                ]),
                                                Text(
                                                    "Correct answer was ${widget.answer}.",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5)),
                                                Text(expertAdvice),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Proceed'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                //this is where it either sends them to next patient
                                                //or back to main gameplay screen
                                                if (lastPatient) {
                                                  navigateToGameplay(context);
                                                } else {
                                                  navigateBackToGame(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
//=================================END OF SABO MAN KEEP FUNCTION, BELOW CODE IS UNTOUCHED==========================
                                },
                              ),
                              TextButton(
                                child: Text('Answer Again'),
                                onPressed: () {
                                  changeAnswer = true;
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      if (data == disease) {
                        //-------IF THEY GOT IT RIGHT!!!---------------------------------
                        correct = true;
                        if (snapshot.data['soundSetting'] == 1) {
                          cache.play("correct.mp3");
                        }
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new FutureBuilder(
                                future: getCustomizations(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>> data) {
                                  return AlertDialog(
                                    //Show correct doctor man in a widget here ?
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('CORRECT!'),
                                          Stack(children: <Widget>[
                                            if (data.hasData)
                                              if (data.data['labCoatColor'] ==
                                                  "none")
                                                Image.asset(
                                                  'assets/images/alien.png',
                                                  fit: BoxFit.cover,
                                                  scale: 4.5,
                                                ),
                                            if (data.data["labCoatColor"]
                                                    .toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["labCoatColor"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["background"]
                                                    .toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["background"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["hatAccessory"]
                                                    .toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["hatAccessory"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["headband"]
                                                    .toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["headband"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["mask"].toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["mask"].toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["pet"].toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["pet"].toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              ),
                                            if (data.data["stethoscope"]
                                                    .toString() !=
                                                "none")
                                              Image.asset(
                                                data.data["stethoscope"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                scale: 4.5,
                                              )
                                          ]),
                                          Text(
                                              "Correct answer is ${widget.answer}.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5)),
                                          Text(expertAdvice),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Proceed'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //this is where it either sends them to next patient
                                          //or back to main gameplay screen
                                          if (lastPatient) {
                                            navigateToGameplay(context);
                                          } else {
                                            navigateBackToGame(context);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      } else {
                        //------------IF THEY GOT IT WRONG!!!-------------------------------
                        if (snapshot.data['soundSetting'] == 1) {
                          cache.play("incorrect.mp3");
                        }
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              //Show incorrect doctor man in a widget here ?
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('INCORRECT'),
                                    Stack(children: <Widget>[
                                      Image.asset(
                                        'assets/images/alien_incorrect.png',
                                        fit: BoxFit.cover,
                                        scale: 4.5,
                                      ),
                                    ]),
                                    Text("Correct answer was ${widget.answer}.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Padding(padding: EdgeInsets.only(top: 5)),
                                    Text(expertAdvice),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Proceed'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    //this is where it either sends them to next patient
                                    //or back to main gameplay screen
                                    if (lastPatient) {
                                      navigateToGameplay(context);
                                    } else {
                                      navigateBackToGame(context);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  }
                },
              ),
            );
          });
    }
    //==============================================================================

    //==============================================================================
    //          Return structure of page
    //==============================================================================
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis?'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/alien.png"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              // draggable widgets here
              children: <Widget>[
                // SizedBox(height: MediaQuery.of(context).size.height / 4),
                draggableButton,
                // SizedBox(height: MediaQuery.of(context).size.height / 8),
                // Container(
                //   padding: const EdgeInsets.only(bottom: 6, top: 6, left: 6, right: 6),
                //   margin: EdgeInsets.only(left: 20, right: 20),
                //   height:  MediaQuery.of(context).size.height / 8,
                //   width: MediaQuery.of(context).size.width / 2,
                //   decoration: BoxDecoration(
                //     color: Colors.blue[50],
                //     border: Border.all(color: Colors.black, width: 3),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [Text("Drag the red box to your answer to see if you are correct! Good Luck!",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))],
                //   ),
                // ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              // droppable widgets here
              children: [
//              Container(width: 100, height: 80),
                _targetBox(MyFlutterApp.heart, "CHF"),
                _targetBox(MyFlutterApp.copd, "COPD"),
                _targetBox(MyFlutterApp.pneumonia, "PNEUMONIA"),
              ],
            )
          ],
        ),
      ),
    );
    //==============================================================================
  }

  //                button builder helper functions
  //==============================================================================
  Material _buildButton(Color color, IconData icon, String label) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 100,
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
            decoration: BoxDecoration(
              color: Color(0x000E3311).withOpacity(0.7),
              border: Border.all(color: Colors.black54, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300].withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 30),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Material _buildDiagnoseButton(Color color, IconData icon, String label) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 110,
            //height: 80,
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300].withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 26),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //=============================================================================

  //IF MORE PATIENTS LEFT
  Future navigateBackToGame(context) async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientCard(
          patientsLeft: remaining,
        ),
      ),
    );
  }

  //IF THIS WAS LAST PATIENT IN GAME SESSION
  Future navigateToGameplay(context) async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
  }
}
