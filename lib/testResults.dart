import 'package:flutter/material.dart';

class Tests extends StatefulWidget {
  Tests({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestsState createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: Text('1'),
              title: Text("White blood cells"),
              subtitle: Text("14.2")),
          ListTile(
              leading: Text('2'),
              title: Text("Hemoglobin"),
              subtitle: Text("13.6")),
          ListTile(
              leading: Text('3'),
              title: Text("Hematocrit"),
              subtitle: Text("40.1")),
          ListTile(
              leading: Text('4'),
              title: Text("Platelets"),
              subtitle: Text("247")),
          ListTile(
              leading: Text('5'), title: Text("Sodium"), subtitle: Text("137")),
          ListTile(
              leading: Text('6'),
              title: Text("Potassium"),
              subtitle: Text("4.2")),
          ListTile(
              leading: Text('7'),
              title: Text("Chloride"),
              subtitle: Text("104")),
          ListTile(
              leading: Text('8'),
              title: Text("Bicarbonate"),
              subtitle: Text("21")),
          ListTile(
              leading: Text('9'), title: Text("BUN"), subtitle: Text("24")),
          ListTile(
              leading: Text('10'),
              title: Text("Creatinine"),
              subtitle: Text("1.6")),
          ListTile(
              leading: Text('11'),
              title: Text("Glucose"),
              subtitle: Text("137")),
          ListTile(
              leading: Text('12'), title: Text("BNP"), subtitle: Text("37")),
          ListTile(
              leading: Text('13'),
              title: Text("ABG - pH"),
              subtitle: Text("7.35")),
          ListTile(
              leading: Text('14'),
              title: Text("ABG - pCO\u2082"),
              subtitle: Text("39")),
          ListTile(
              leading: Text('15'),
              title: Text("ABG - pO\u2082"),
              subtitle: Text("71")),
          ListTile(
              leading: Text('16'),
              title: Text("Lactate"),
              subtitle: Text("2.4")),
        ],
      ),
    );
  }
}
