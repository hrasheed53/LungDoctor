import 'package:flutter/material.dart';

class Physical extends StatefulWidget {
  Physical({
    Key key,
    this.examSummary,
    this.patient,
    this.head,
    this.neck,
    this.heart,
    this.lungs,
    this.ab,
    this.ext,
    this.skin,
  }) : super(key: key);

  List<String> examSummary;
  String patient;
  String head;
  String neck;
  String heart;
  String lungs;
  String ab;
  String ext;
  String skin;


  @override
  _PhysicalState createState() => _PhysicalState();
}

class _PhysicalState extends State<Physical> {
  @override
  Widget build(BuildContext context) {
    //highlight stuff
    bool pressGeneral = false;
    bool presshead = false;
    bool pressneck = false;
    bool pressheart = false;
    bool presslungs = false;
    bool pressab = false;
    bool pressext = false;
    bool pressskin = false;
    List<String> examSummary = widget.examSummary;

    String patient = widget.patient;
    String head = widget.head;
    if (widget.head == "") {
      widget.head = "No Info";
    }
    String heart = widget.heart;
    if (widget.neck == "") {
      widget.neck = "No Info";
    }
    String neck = widget.neck;
    if (widget.lungs == "") {
      widget.lungs = "No Info";
    }
    String lungs = widget.lungs;
    if (widget.ab == "") {
      widget.ab = "No Info";
    }
    String ab = widget.ab;
    if (widget.ext == "") {
      widget.ext = "No Info";
    }
    String ext = widget.ext;
    if (widget.skin == "") {
      widget.skin = "No Info";
    }
    String skin = widget.skin;



    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("General",
                textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: TextButton(
                child: new Text(
                  patient,
                  style: pressGeneral
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressGeneral = !pressGeneral,
                  );
                  if (!pressGeneral) {
                    examSummary.remove("General - " + patient);
                  } else {
                    examSummary.add("General - " + patient);
                  }
                }),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text("Head",
                textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            subtitle: TextButton(
                child: new Text(
                  head,
                  style: presshead
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => presshead = !presshead,
                  );
                  if (!presshead) {
                    examSummary.remove("Head - " + head);
                  } else {
                    examSummary.add("Head - " + head);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  neck,
                  style: pressneck
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressneck = !pressneck,
                  );
                  if (!pressneck) {
                    examSummary.remove("Neck - " + neck);
                  } else {
                    examSummary.add("Neck - " + neck);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  heart,
                  style: pressheart
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressheart = !pressheart,
                  );
                  if (!pressheart) {
                    examSummary.remove("Heart - " + heart);
                  } else {
                    examSummary.add("Heart - " + heart);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  lungs,
                  style: presslungs
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => presslungs = !presslungs,
                  );
                  if (!presslungs) {
                    examSummary.remove("Lungs - " + lungs);
                  } else {
                    examSummary.add("Lungs - " + lungs);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  ab,
                  style: pressab
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressab = !pressab,
                  );
                  if (!pressab) {
                    examSummary.remove("Abs - " + ab);
                  } else {
                    examSummary.add("Abs - " + ab);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  ext,
                  style: pressext
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressext = !pressext,
                  );
                  if (!pressext) {
                    examSummary.remove("Extremities - " + ext);
                  } else {
                    examSummary.add("Extremities - " + ext);
                  }
                }),
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
            subtitle: TextButton(
                child: new Text(
                  skin,
                  style: pressskin
                      ? TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Colors.black,
                          fontSize: 18.0,
                        )
                      : TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                ),
                onPressed: () {
                  setState(
                    () => pressskin = !pressskin,
                  );
                  if (!pressskin) {
                    examSummary.remove("Skin - " + skin);
                  } else {
                    examSummary.add("Skin - " + skin);
                  }
                }),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}

