import 'package:flutter/material.dart';
import 'settings.dart';
import 'leaderboard.dart';
import 'newFrontPage.dart';
import 'statsPage.dart';
import 'store.dart';

//TO CALL THIS MAIN PAGE:
//use Instr(i:<int index of page to start on>)
//ex: Instr(i:0);

//yea ignore that ignore thing thanks
// ignore: must_be_immutable
class Instr extends StatefulWidget {
  //final int i = 0;
  Instr({Key key, @required this.i}) : super(key: key);
  int i;

  @override
  _InstrState createState() => _InstrState();
}

class _InstrState extends State<Instr> {
  final _widgetOptions = [
    //THIS IS WHERE THE PAGES GO

    new FrontPage(),
    new LeaderBoard(),
    new Settings(),
    new Store(),
    new StatsPage()
  ];
  final _appbarWords = [
    //HEADERS FOR THE PAGES IN NAVBAR
    Text('Welcome!'),
    Text('Leaderboard'),
    Text('Settings'),
    Text('Store'),
    Text('Statistics')
  ];

  //_InstrState(i);
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    //hacky but whatever
    if (widget.i != 0) {
      _selectedIndex = widget.i;
      widget.i = 0;
    }
    // else if (widget.i == 0 && _selectedIndex == Null) {}

    return Scaffold(
      appBar: AppBar(
          title: _appbarWords.elementAt(_selectedIndex),
          leading: Container(),
          centerTitle: true),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedItemColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.games, color: Colors.blue),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward, color: Colors.blue),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.blue),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.blue),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll, color: Colors.blue),
            label: 'Stats',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
