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
      body: Text(
        'hello testing',
      ),
      bottomNavigationBar: navBar(),
    );
  }
}
