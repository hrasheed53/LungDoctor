import 'package:RESP2/gamePlay.dart';
import 'package:RESP2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'instructions.dart';
import 'signIn.dart';
import 'main.dart';

//import 'navBar.dart';

class FrontPage extends StatefulWidget {
  FrontPage({Key key}) : super(key: key);
  @override
  FrontPageState createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage> {
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
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                child: Text("Start Game",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
                  );
                })),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.help, color: Colors.blue[600]),
            iconSize: 50,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inst(),
                  ));
            },
          ),
        ),
        MaterialButton(
            elevation: 5.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            color: Colors.blue[600],
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), ModalRoute.withName('/'));
            },
            child: Text(
              "Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ]),
    ));
  }
}
