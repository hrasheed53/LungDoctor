import 'package:RESP2/userData.dart';
import 'package:flutter/material.dart';
import 'package:RESP2/patientcard.dart';
import 'package:RESP2/gamePlay.dart';
import 'dart:math';

class Diagnose extends StatefulWidget {
  Diagnose({Key key, @required this.patientsLeft}) : super(key: key);
  final int patientsLeft;

  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  int remaining;
  //variables to be used:
  String ans = "CHF";
  bool correct = false;
  //List<String> illnesses = ["CHF", "COPD", "PNEUMONIA"];
  //List rejectedData;
  bool lastPatient = false;
  bool changeAnswer = false;
  String difficultyLevel = "easy";
  var randint = Random();

  @override
  Widget build(BuildContext context) {
    remaining = widget.patientsLeft;
    if (widget.patientsLeft == 0) {
      lastPatient = true;
    }

    //==============================================================================
    //                Button to be dragged:
    //==============================================================================
    Widget draggableButton = Draggable<String>(
      data: "CHF",
      child: _buildButton(
          const Color(0xffe34646), Icons.local_pharmacy, 'DIAGNOSE'),
      feedback: _buildButton(
          const Color(0xffe34646), Icons.local_pharmacy, 'DIAGNOSE'),
      childWhenDragging: Container(
        width: 100,
        height: 80,
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
    Widget _targetBox(String disease) {
      return Material(
        child: DragTarget<String>(
          builder: (context, List<String> incoming, List rejected) {
            return _buildButton(
                const Color(0xffe34646), Icons.local_pharmacy, disease);
          },
          //onWillAccept: (data) => data == disease,
          onAccept: (data) {
            //NEED TO CALL UPDATESTATISTICS() FUNCTION HERE W/ CORRECT DIAGNOSIS, RIGHT/WRONG, AND DIFFICULTY!!!!!!!
            updateStatistics(data, difficultyLevel, data == disease);

            //sabotage logic, for now its a 1 in 3 chance he shows up
            bool sabotage;
            if (changeAnswer) {
              sabotage = false;
            } else {
              sabotage = randint.nextInt(2) == 0;
            }

            //for logic in case they change answer, doesnt get updated unless sabo shows up

            if (sabotage) {
              //and a 1 in 3 chance he is giving good advice
              bool sabotageCorrect = randint.nextInt(2) == 0;

              correct = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //Show correct doctor man in a widget here ?
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                              'WAIT! Before you answer, your "friendly" neighborhood doctor has some advice for you!'),
                          Text(sabotageCorrect ? 'Good advice' : 'Bad advice')
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      /*
                      TextButton(
                        child: Text('Keep answer'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),*/
                      TextButton(
                        child: Text('Change answer'),
                        onPressed: () {
                          changeAnswer = true;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );

              //its hacky but stfu im tired and dont want to fix the repeated code sue me

            } else {
              if (data == disease) {
                //-------IF THEY GOT IT RIGHT!!!---------------------------------
                correct = true;
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //Show correct doctor man in a widget here ?
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('CORRECT'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Proceed'),
                          onPressed: () {
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
              } else {
                //------------IF THEY GOT IT WRONG!!!-------------------------------
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
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Proceed'),
                          onPressed: () {
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
          },
        ),
      );
    }
    //==============================================================================

    //==============================================================================
    //          Return structure of page
    //==============================================================================
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/beginningGameBG.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              // draggable widgets here
              children: [
                draggableButton,
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              // droppable widgets here
              children: [
//              Container(width: 100, height: 80),
                _targetBox("CHF"),
                _targetBox("COPD"),
                _targetBox("PNEUMONIA"),
              ],
            )
          ],
        ),
      ),
    );
    //==============================================================================
  }

  //                button builder helper function
  //==============================================================================
  Material _buildButton(Color color, IconData icon, String label) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 24),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientCard(
                  patientsLeft: remaining,
                )));
  }

  //IF THIS WAS LAST PATIENT IN GAME SESSION
  Future navigateToGameplay(context) async {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
  }
}
