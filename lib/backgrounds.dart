import 'package:flutter/material.dart';
//import 'store.dart';

String currentImage = 'assets/images/alien.png';
String newImage = '';

class background extends StatefulWidget {
  background({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _backgroundState createState() => _backgroundState();
}

class _backgroundState extends State<background> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Background customization"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  currentImage,
                  fit: BoxFit.cover,
                  scale: 4.5,
                ),
                if (newImage != '')
                  Image.asset(
                    newImage,
                    fit: BoxFit.cover,
                    scale: 4.5,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buttonHelper("Hearts", "alien_background_hearts.png"),
                buttonHelper("Swirls", "alien_background_swirls.png"),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              buttonHelper("Fruit", "alien_background_fruit.png"),
              buttonHelper("Lightning", "alien_background_lightening.png"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              buttonHelper("Rainbow", "alien_background_rainbow.png"),
              buttonHelper("Clouds", "alien_background_cloud.png"),
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
                      onTap: () {},
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

  Widget buttonHelper(name, filename) {
    return Container(
      height: 50,
      width: 130,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              newImage = 'assets/images/' + filename;
            });
          },
          splashColor: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
