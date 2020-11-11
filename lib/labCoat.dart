import 'package:flutter/material.dart';
import 'store.dart';

String currentImage = 'assets/images/alien.png';

class LabCoat extends StatefulWidget {
  LabCoat({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LabCoatState createState() => _LabCoatState();
}

class _LabCoatState extends State<LabCoat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Coat customization"),
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            Container(
              child: Image.asset(currentImage,
              fit: BoxFit.cover,
              scale: 4.5,)
            ),
            Row(children: <Widget> [
              Container(
                height: 50,
                width: 100,
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {currentImage = 'assets/images/alien_labcoat_red.png';});
                    },
                    splashColor: Colors.red[600],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Red",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[600])),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                Container(
                  height: 50,
                  width: 100,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_pink.png';});
                      },
                      splashColor: Colors.pink[300],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Pink",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[300])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 130,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_orange.png';});
                      },
                      splashColor: Colors.orange[300],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Orange",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[300])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ],),
                Row(children: <Widget>[
                Container(
                  height: 50,
                  width: 130,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_yellow.png';});
                      },
                      splashColor: Colors.yellow[600],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Yellow",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[600])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 115,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_green.png';});
                      },
                      splashColor: Colors.green[400],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Green",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[400])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_blue.png';});
                      },
                      splashColor: Colors.blue[300],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Blue",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[300])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ]),
                Row(children: <Widget>[
                Container(
                  height: 50,
                  width: 130,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_purple.png';});
                      },
                      splashColor: Colors.purple[600],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Purple",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[600])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 115,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien_labcoat_black.png';});
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Black",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {currentImage = 'assets/images/alien.png';});
                      },
                      splashColor: Colors.grey[600],
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("White",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ]),
            Row(children: <Widget>[
            Container(
              height: 50,
              width: 350,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                margin: EdgeInsets.all(8.0),
                color: Colors.blue[600],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Store(),
                    ));
                  },
                  splashColor: Colors.grey[600],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Save",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ],),
          ],
        ),
        ),
      ); //   <-- image
  }
}