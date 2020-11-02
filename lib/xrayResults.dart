import 'package:flutter/material.dart';

class Xray extends StatefulWidget {
  Xray({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _XrayState createState() => _XrayState();
}

class _XrayState extends State<Xray> {
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
