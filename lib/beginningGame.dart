import 'package:flutter/material.dart';
import 'navBar.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/beginningGameBG.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Welcome!',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.help, color: Colors.redAccent),
              iconSize: 50,
              onPressed: () {},
            ),
          )
        ]),
      ),
      bottomNavigationBar: navBar(),
    );
  }
}
