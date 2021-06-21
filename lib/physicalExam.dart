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
            title: Text("Head",
            textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              head,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Neck",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              neck,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Heart",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              heart,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Lungs",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              lungs,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Abdomen",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              ab,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Extremities",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              ext,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Skin",
            textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: Text(
              skin,
              style: TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
