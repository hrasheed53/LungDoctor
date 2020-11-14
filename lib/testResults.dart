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
              subtitle: Text("14.2 K/uL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('2'),
              title: Text("Hemoglobin"),
              subtitle: Text("13.6 g/dL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('3'),
              title: Text("Hematocrit"),
              subtitle: Text("40.1 %")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('4'),
              title: Text("Platelets"),
              subtitle: Text("247 K/uL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('5'),
              title: Text("Sodium"),
              subtitle: Text("137 mmol/L")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('6'),
              title: Text("Potassium"),
              subtitle: Text("4.2 mmo/L")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('7'),
              title: Text("Chloride"),
              subtitle: Text("104 mmo/L")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('8'),
              title: Text("Bicarbonate"),
              subtitle: Text("21 mmo/L")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('9'),
              title: Text("BUN (blood urea nitrogen)"),
              subtitle: Text("24 mg/dL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('10'),
              title: Text("Creatinine"),
              subtitle: Text("1.6 mg/dL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('11'),
              title: Text("Glucose"),
              subtitle: Text("137 mg/dL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('12'),
              title: Text("BNP"),
              subtitle: Text("37 mg/dL")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('13'),
              title: Text("ABG (arterial blood gas)"),
              subtitle: Text("pH 7.35")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('14'),
              title: Text("ABG - pCO\u2082"),
              subtitle: Text("39 mm Hg")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('15'),
              title: Text("ABG - pO\u2082"),
              subtitle: Text("71 mm Hg")),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('16'),
              title: Text("Lactate"),
              subtitle: Text("2.4 mmol/L")),
        ],
      ),
    );
  }
}
