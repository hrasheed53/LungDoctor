import 'package:flutter/material.dart';

class Diagnose extends StatefulWidget {
  Diagnose({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  //variables to be used:
  String ans = "CHF";
  bool correct = false;
  //List<String> illnesses = ["CHF", "COPD", "PNEUMONIA"];
  //List rejectedData;

  @override
  Widget build(BuildContext context) {
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
            /*
            if (disease == ans) {
              return _buildButton(
                  const Color(0xffe34646), Icons.local_pharmacy, disease);
            } else {
              return _buildButton(
                  const Color(0xffe34646), Icons.local_pharmacy, "rand");
            }*/
          },
          onWillAccept: (data) => data == disease,
          onAccept: (data) {
            correct = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  //title: Text('Ready?'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Are you prepared to diagnose your patient?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No, back to chart'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Let\'s diagnose!'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
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
}
