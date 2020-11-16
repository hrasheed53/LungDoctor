import 'package:flutter/material.dart';

class Tests extends StatefulWidget {
  Tests(
      {Key key,
      this.title,
      this.wbc,
      this.hemo,
      this.hema,
      this.plat,
      this.na,
      this.k,
      this.cl,
      this.c,
      this.bun,
      this.creat,
      this.glucose,
      this.bnp,
      this.abgph,
      this.abgpo,
      this.abgpo2,
      this.lactate})
      : super(key: key);

  final String title;
  final String wbc;
  final String hemo;
  final String hema;
  final String plat;
  final String na;
  final String cl;
  final String k;
  final String c;
  final String bun;
  final String creat;
  final String glucose;
  final String bnp;
  final String abgph;
  final String abgpo;
  final String abgpo2;
  final String lactate;

  @override
  _TestsState createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  @override
  Widget build(BuildContext context) {
    String whiteBloodCells = widget.wbc;
    String hemo = widget.hemo;
    String hema = widget.hema;
    String plat = widget.plat;
    String na = widget.na;
    String cl = widget.cl;
    String k = widget.k;
    String c = widget.c;
    String bun = widget.bun;
    String creat = widget.creat;
    String glucose = widget.glucose;
    String bnp = widget.bnp;
    String abgph = widget.abgph;
    String abgpo = widget.abgpo;
    String abgpo2 = widget.abgpo2;
    String lactate = widget.lactate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: Text('1'),
              title: Text("White blood cells"),
              subtitle: Text(whiteBloodCells + " K/uL")),
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
              subtitle: Text(hemo + " g/dL")),
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
              subtitle: Text(hema + "%")),
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
              subtitle: Text(plat + " K/uL")),
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
              subtitle: Text(na + " mmol/L")),
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
              subtitle: Text(k + " mmo/L")),
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
              subtitle: Text(cl + " mmo/L")),
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
              subtitle: Text(c + " mmo/L")),
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
              subtitle: Text(bun + " mg/dL")),
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
              subtitle: Text(creat + " mg/dL")),
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
              subtitle: Text(glucose + " mg/dL")),
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
              subtitle: Text(bnp + " mg/dL")),
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
              subtitle: Text("pH " + abgph)),
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
              subtitle: Text(abgpo2 + " mm Hg")),
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
              subtitle: Text(abgpo + " mm Hg")),
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
              subtitle: Text(lactate + " mmol/L")),
        ],
      ),
    );
  }
}
