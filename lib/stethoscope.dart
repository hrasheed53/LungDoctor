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

class Stethoscope extends StatefulWidget {
  Stethoscope({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StethoscopeState createState() => _StethoscopeState();
}

class _StethoscopeState extends State<Stethoscope> {
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
              title: Text("Stethoscope customization"),
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
                      buttonHelper("Option  1", "stethescope_1.png"),
                      buttonHelper("Option  2", "stethescope_2.png"),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buttonHelper("Option  3", "stethescope_3.png"),
                        buttonHelper("Option  4", "stethescope_4.png"),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buttonHelper("Option  5", "stethescope_5.png"),
                        buttonHelper("Option  6", "stethescope_6.png"),
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
            scale: 5,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setCustomization("stethoscope", newImage);
                  if (soundOn == 1) {
                    cache.play("cash.mp3");
                  }
                  new FutureBuilder(
                    future: spendPoints(200),
                    builder: (BuildContext context, AsyncSnapshot<int> data) {
                      return;
                    },
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Instr(i: 3)));
                },
                child: Text('OK')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('CANCEL')),
          ],
        );
      });
}
