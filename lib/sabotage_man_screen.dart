import 'package:flutter/material.dart';

class sabotage extends StatefulWidget {
  sabotage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _sabotageState createState() => _sabotageState();
}

class _sabotageState extends State<sabotage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget> [
          Row(children: <Widget>[
            Image.asset('assets/images/alien.png',
              fit: BoxFit.cover,
              scale: 4.5,),
            
          ],)
        ])
      )
    );
  }
}