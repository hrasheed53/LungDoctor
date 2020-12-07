import 'package:RESP2/hatAccessories.dart';
import 'package:RESP2/headbands.dart';
import 'package:RESP2/masks.dart';
import 'package:RESP2/pets.dart';
import 'package:RESP2/userData.dart';

import 'labCoat.dart';
import 'hatAccessories.dart';
import 'backgrounds.dart';
import 'stethoscope.dart';
import 'headbands.dart';
import 'masks.dart';
import 'pets.dart';
import 'package:flutter/material.dart';

int points = 0;

class Store extends StatefulWidget {
  Store({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        // appBar: AppBar(
        //   title: const Text('Store'),
        // ),
        future: getStorePoints(),
        builder: (BuildContext context, AsyncSnapshot<int> data) {
          if (data.hasData) {
            points = data.data;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Text('You have ' + points.toString() + ' spending points',
                        style: TextStyle(fontSize: 25)),
                    if (points >= 100) oneHundredClick(),
                    if (points < 100) oneHundredNoClick(),
                    if (points >= 200) twoHundredClick(),
                    if (points < 200) twoHundredNoClick(),
                    if (points >= 300) threeHundredClick(),
                    if (points < 300) threeHundredNoClick(),
                    SizedBox(height: 35),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }
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

  Card oneHundredClick() {
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
                    builder: (context) => Background(),
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
                    builder: (context) => HatAccessories(),
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

  Card oneHundredNoClick() {
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

  Card twoHundredClick() {
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
                    builder: (context) => Stethoscope(),
                  ));
            },
            leading: Icon(Icons.check_rounded, color: Colors.blue[300]),
            title: Text('Stethoscopes'),
            trailing: Icon(Icons.arrow_right_alt_rounded),
          ),
          line(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Headbands(),
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
                    builder: (context) => Masks(),
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

  Card twoHundredNoClick() {
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
            title: Text('Stethoscopes'),
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

  Card threeHundredClick() {
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
                    builder: (context) => Pets(),
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

  Card threeHundredNoClick() {
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
