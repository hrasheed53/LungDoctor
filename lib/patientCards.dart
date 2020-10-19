import 'package:flutter/material.dart';
import 'navBar.dart';


class Patient extends StatefulWidget {
  Patient({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Card'),
      ),
      body: navBar(),
    );
  }
}