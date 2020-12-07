import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'beginningGame.dart';
import 'userData.dart';

String currentImage = 'assets/images/alien.png';
String newImage = '';
int soundOn;
AudioCache cache = new AudioCache();

class HatAccessories extends StatefulWidget {
  HatAccessories({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HatAccessoriesState createState() => _HatAccessoriesState();
}

class _HatAccessoriesState extends State<HatAccessories> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: settings(),
        builder:
            (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
          if (snapshot.hasData) {
            soundOn = snapshot.data['soundSetting'];
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Simple Accessories customization"),
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
                      if (newImage == 'assets/images/alien_hat1.png')
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 5,
                        ),
                      if (newImage == 'assets/images/alien_hat2.png')
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 4,
                        ),
                      if (newImage == 'assets/images/alien_flowercrown.png')
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 4.5,
                        ),
                      if (newImage == 'assets/images/alien_flowers.png')
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 4,
                        )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buttonHelper("Hat 1", "alien_hat1.png"),
                      buttonHelper("Hat 2", "alien_hat2.png"),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buttonHelper("Flowers", "alien_flowercrown.png"),
                        buttonHelper("Flowers 2", "alien_flowers.png"),
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
                            onTap: () => _popupDialog(context),
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
          );
        }); //   <-- image
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

void _popupDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('You just bought a customization'),
          content: Image.asset(
            newImage,
            fit: BoxFit.cover,
            scale: 4.5,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  setCustomization("hatAccessory", newImage);
                  if (soundOn == 1) {
                    cache.play("cash.mp3");
                  }
                  new FutureBuilder(
                    future: spendPoints(100),
                    builder: (BuildContext context, AsyncSnapshot<int> data) {},
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Instr(i: 3)));
                },
                child: Text('OK')),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('CANCEL')),
          ],
        );
      });
}
