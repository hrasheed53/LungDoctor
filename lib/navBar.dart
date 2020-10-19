import 'package:RESP2/main.dart';
import 'package:flutter/material.dart';
import 'gamePlay.dart';
import 'leaderboard.dart';
import 'settings.dart';
import 'store.dart';

class navBar extends StatefulWidget {
  @override
  _navBarState createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Game(),
          ));
    }
    if (_selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeaderBoard(),
          ));
    }
    if (_selectedIndex == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Settings(),
          ));
    }
    if (_selectedIndex == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Store(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          label: 'Leader Board',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.blue),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag, color: Colors.blue),
          label: 'Store',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
