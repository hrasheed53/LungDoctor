import 'package:flutter/material.dart';
import 'navBar.dart';
import 'sabatogeInstructions.dart';


class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.blue[50],
              margin: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  //if we want to add edit profile functionality
                },
                title: Text('Name goes here'),
                leading: CircleAvatar(backgroundColor: Colors.blue,),
                trailing: Icon(Icons.edit),
              )
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.white,
              margin: const EdgeInsets.all(10.0),
              child: Column (
                children: <Widget> [
                ListTile(
                  onTap: () {
                    //if we want to add edit profile functionality
                  },
                  leading: Icon(Icons.portrait, color: Colors.blue[200]),
                  title: Text('Change Name'),
                  trailing: Icon(Icons.arrow_right_alt_rounded),
                ),
                line(),
                ListTile(
                  onTap: () {
                    //if we want to add edit profile functionality
                  },
                  leading: Icon(Icons.lock_outline_rounded, color: Colors.blue[200]),
                  title: Text('Change Password'),
                  trailing: Icon(Icons.arrow_right_alt_rounded),
                ),
                line(),
                ListTile(
                  onTap: () {
                    //if we want to add edit profile functionality
                  },
                  leading: Icon(Icons.language_rounded, color: Colors.blue[200]),
                  title: Text('Change Language'),
                  trailing: Icon(Icons.arrow_right_alt_rounded),
                ),
              ],
              ),
            ),
            const SizedBox(height: 5.0),
            Text('On/Off options', style: TextStyle(fontSize: 25)),
            SwitchListTile(
              activeColor: Colors.blue[300],
              contentPadding: const EdgeInsets.all(5.0),
              value: true,
              title: Text('Sabatoge Man'),
              onChanged: (val){},
            ),
            SwitchListTile(
              activeColor: Colors.blue[300],
              contentPadding: const EdgeInsets.all(5.0),
              value: true,
              title: Text('Sound effects'),
              onChanged: (val){},
            ),
            SwitchListTile(
              activeColor: Colors.blue[300],
              contentPadding: const EdgeInsets.all(5.0),
              value: true,
              title: Text('Reminders to play'),
              onChanged: (val){},

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
      bottomNavigationBar: navBar(),
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