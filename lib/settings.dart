import 'package:flutter/material.dart';
import 'package:RESP2/userData.dart';
import 'changeName.dart';
import 'sabotageInstructions.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSab;
  bool isSound;
  bool isSwitched3 = false;
  bool isEasy;
  bool isMed;
  bool isHard;
  String name = '';
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: settings(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> data) {
          if (data.hasData) {
            if (data.data['soundSetting'] == 0) {
              isSound = false;
            } else if (data.data['soundSetting'] == 1) {
              isSound = true;
            }
            if (data.data["sabotageSetting"] == 0) {
              isSab = false;
            } else if (data.data["sabotageSetting"] == 1) {
              isSab = true;
            }
            if (data.data["easySetting"] == 0) {
              isEasy = false;
            } else if (data.data["easySetting"] == 1) {
              isEasy = true;
            }
            if (data.data["mediumSetting"] == 0) {
              isMed = false;
            } else if (data.data["mediumSetting"] == 1) {
              isMed = true;
            }
            if (data.data["hardSetting"] == 0) {
              isHard = false;
            } else if (data.data["hardSetting"] == 1) {
              isHard = true;
            }
          } else {
            return Scaffold(
              body: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          //isSab2 = isSab;
          return Scaffold(
            //  appBar: AppBar(
            //     title: const Text('Settings'),
            //   ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.blue[50],
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () {
                          //if we want to add edit profile functionality
                        },
                        title: Text(name),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        trailing: Icon(Icons.edit),
                      )),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCustomForm()));
                          },
                          leading:
                              Icon(Icons.portrait, color: Colors.blue[200]),
                          title: Text('Change Name'),
                          trailing: Icon(Icons.arrow_right_alt_rounded),
                        ),
                        line(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text('On/Off options', style: TextStyle(fontSize: 25)),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSab,
                    title: Text('Sabotage Man'),
                    onChanged: (value) {
                      setState(() {
                        if (isSab) {
                          setSabotageSetting(0);
                        } else {
                          setSabotageSetting(1);
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSound,
                    title: Text('Sound effects'),
                    onChanged: (value) {
                      setState(() {
                        if (isSound) {
                          setSoundSetting(0);
                        } else {
                          setSoundSetting(1);
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSwitched3,
                    title: Text('Easy Level Cases'),
                    onChanged: (value) {
                      setState(() {
                        if (isEasy) {
                          setEasySetting(0);
                        } else {
                          setEasySetting(1);
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSwitched3,
                    title: Text('Medium Level Cases'),
                    onChanged: (value) {
                      setState(() {
                        if (isMed) {
                          setMediumSetting(0);
                        } else {
                          setMediumSetting(1);
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSwitched3,
                    title: Text('Hard Level Cases'),
                    onChanged: (value) {
                      setState(() {
                        if (isHard) {
                          setHardSetting(0);
                        } else {
                          setHardSetting(1);
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(5.0),
                    value: isSwitched3,
                    title: Text('Reminders to play'),
                    onChanged: (value) {
                      setState(() {
                        isSwitched3 = !isSwitched3;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: Icon(Icons.help, color: Colors.blue[600]),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QA(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.blueGrey[300],
    );
  }
}
