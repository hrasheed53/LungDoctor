import 'package:flutter/material.dart';

class Diagnose extends StatefulWidget {
  Diagnose({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: ListView(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CHF!'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('COPD!'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Pneumonia!'),
          ),
        ],
      ),
    );
  }
}
