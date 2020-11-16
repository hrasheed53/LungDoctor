import 'package:flutter/material.dart';

class Physical extends StatefulWidget {
  Physical({
    Key key,
    this.head,
    this.neck,
    this.heart,
    this.lungs,
    this.ab,
    this.ext,
    this.skin,
  }) : super(key: key);

  final String head;
  final String neck;
  final String heart;
  final String lungs;
  final String ab;
  final String ext;
  final String skin;

  @override
  _PhysicalState createState() => _PhysicalState();
}

class _PhysicalState extends State<Physical> {
  @override
  Widget build(BuildContext context) {
    String head = widget.head;
    String heart = widget.heart;
    String neck = widget.neck;
    String lungs = widget.lungs;
    String ab = widget.ab;
    String ext = widget.ext;
    String skin = widget.skin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: Text('1'), title: Text("Head"), subtitle: Text(head)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('2'), title: Text("Neck"), subtitle: Text(neck)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('3'), title: Text("Heart"), subtitle: Text(heart)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('4'), title: Text("Lungs"), subtitle: Text(lungs)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('5'), title: Text("Abdomen"), subtitle: Text(ab)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('6'),
              title: Text("Extremities"),
              subtitle: Text(ext)),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
              leading: Text('7'), title: Text("Skin"), subtitle: Text(skin)),
        ],
      ),
    );
  }
}
