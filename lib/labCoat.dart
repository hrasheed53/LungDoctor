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
          children: <Widget>[
            Container(
                child: Image.asset(
              currentImage,
              fit: BoxFit.cover,
              scale: 4.5,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                colorButton(
                    context, Colors.red[600], "Red", "alien_labcoat_red.png"),
                colorButton(context, Colors.pink[300], "Pink",
                    "alien_labcoat_pink.png"),
                colorButton(context, Colors.orange[300], "Orange",
                    "alien_labcoat_orange.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              colorButton(context, Colors.yellow[600], "Yellow",
                  "alien_labcoat_yellow.png"),
              colorButton(context, Colors.green[400], "Green",
                  "alien_labcoat_green.png"),
              colorButton(
                  context, Colors.blue[300], "Blue", "alien_labcoat_blue.png"),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              colorButton(context, Colors.purple[600], "Purple",
                  "alien_labcoat_purple.png"),
              colorButton(
                  context, Colors.black, "Black", "alien_labcoat_black.png"),
              colorButton(context, Colors.grey[600], "White", "alien.png"),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
              ],
            ),
          ],
        ),
      ),
    ); //   <-- image
  }

  Widget colorButton(context, colorValue, colorName, imageFileName) {
    //colorValue == Color object, color name = stringname ("pink"), imagefilename = string.png
    return Container(
      height: 50,
      width: 100,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              currentImage = 'assets/images/' + imageFileName;
            });
          },
          splashColor: Colors.pink[300],
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(colorName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorValue)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
