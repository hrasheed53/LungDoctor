import 'package:RESP2/hataccessories.dart';
import 'package:RESP2/headbands.dart';
import 'package:RESP2/incorrect_answer.dart';
import 'package:RESP2/masks.dart';
import 'package:RESP2/pets.dart';

import 'labCoat.dart';
import 'hataccessories.dart';
import 'backgrounds.dart';
import 'stethescope.dart';
import 'headbands.dart';
import 'masks.dart';
import 'pets.dart';
import 'userData.dart';
import 'package:flutter/material.dart';


int points = 350;

class Store extends StatefulWidget {
  Store({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Store'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text('You have ' + points.toString() + ' spending points',
                style: TextStyle(fontSize: 25)),
            if (points >= 100) one_hundred_click(),
            if (points < 100) one_hundred_noclick(),
            if (points >= 200) two_hundred_click(),
            if (points < 200) two_hundred_noclick(),
            if (points >= 300) three_hundred_click(),
            if (points < 300) three_hundred_noclick(),
            SizedBox(height: 35),
          ],
        ),
      ),
      //bottomNavigationBar: navBar(),
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

  Container thickline() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: 3.0,
      color: Colors.blueGrey[300],
    );
  }

  Card one_hundred_click() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('100 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LabCoat(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Labcoat Color'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => background(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Backgrounds'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => simpAccessories(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Simple accessories'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
        ],
      ),
    );
  }

  Card one_hundred_noclick() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('100 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Labcoat Color'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Backgrounds'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Simple accessories'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
        ],
      ),
    );
  }

  Card two_hundred_click() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('200 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => stethescope(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Stethescopes'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => headbands(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Headbands'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => masks(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Masks'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
        ],
      ),
    );
  }

  Card two_hundred_noclick() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('200 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Stethescopes'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Headbands'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Masks'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
        ],
      ),
    );
  }

  Card three_hundred_click() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('300 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pets(),
              ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Pets'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Color Customization'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
        ],
      ),
    );
  }

  Card three_hundred_noclick() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          thickline(),
          Text('300 point items', style: TextStyle(fontSize: 25)),
          thickline(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Pets'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              //if we want to add edit profile functionality
            },
            leading: Icon(Icons.lock_rounded, color: Colors.blueGrey[300]),
            title: Text('Color Theme'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
        ],
      ),
    );
  }
}
