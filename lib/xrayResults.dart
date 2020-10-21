import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';

class Xrays extends StatefulWidget {
  Xrays({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _XraysState createState() => _XraysState();
}

class _XraysState extends State<Xrays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xray Results'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.network(
              'https://xrayimagesresp2.s3.amazonaws.com/xray_example.png'),
        ),
      ),
    );
  }
}
