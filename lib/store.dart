import 'package:flutter/material.dart';
import 'navBar.dart';


class Store extends StatefulWidget {
  Store({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: navBar(),
    );
  }
}