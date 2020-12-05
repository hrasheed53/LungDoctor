import 'package:flutter/material.dart';
import 'changeName.dart';
import 'sabotageInstructions.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name ='';
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  @override
  Widget build(BuildContext context) {
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
                    leading: Icon(Icons.portrait, color: Colors.blue[200]),
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
              value: isSwitched,
              title: Text('Sabotage Man'),
              onChanged: (value) {
                setState(() {
                  isSwitched = !isSwitched;
                });
              },
            ),
            SwitchListTile(
              activeColor: Colors.blue[300],
              contentPadding: const EdgeInsets.all(5.0),
              value: isSwitched2,
              title: Text('Sound effects'),
              onChanged: (value) {
                setState(() {
                  isSwitched2 = !isSwitched2;
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
