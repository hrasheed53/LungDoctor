import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'store.dart';
import 'beginningGame.dart';
import 'userData.dart';

String currentImage = 'assets/images/alien.png';
String newImage = '';
int soundOn;
AudioCache cache = new AudioCache();

class Masks extends StatefulWidget {
  Masks({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MasksState createState() => _MasksState();
}

class _MasksState extends State<Masks> {
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
              title: Text("Mask customization"),
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
                      if (newImage != '' &&
                          newImage != "assets/images/mask_6.png")
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 4.5,
                        ),
                      if (newImage == "assets/images/mask_6.png")
                        Image.asset(
                          newImage,
                          fit: BoxFit.cover,
                          scale: 4.65,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buttonHelper("Blue", "mask_1.png"),
                      buttonHelper("Blue 2", "mask_2.png"),
                      buttonHelper("Green", "mask_3.png"),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buttonHelper("Yellow", "mask_4.png"),
                        buttonHelper("Orange", "mask_5.png"),
                        buttonHelper("Red", "mask_6.png"),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buttonHelper("Pink", "mask_7.png"),
                        buttonHelper("Purple", "mask_8.png"),
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
      width: 120,
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
                        fontSize: 17,
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

Future<AudioPlayer> playLocalAsset() async {
  AudioCache cache = new AudioCache();
  return await cache.play("assets/Cash Register Sound-9798-Free-Loops.com.mp3");
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
                  setCustomization("mask", newImage);
                  if (soundOn == 1) {
                    cache.play("cash.mp3");
                  }
                  new FutureBuilder(
                    future: spendPoints(200),
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
