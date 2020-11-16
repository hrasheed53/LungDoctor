import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:photo_view/photo_view.dart';

class Xrays extends StatefulWidget {
  Xrays({Key key, this.title, this.caseID}) : super(key: key);
  final int caseID;
  final String title;

  @override
  _XraysState createState() => _XraysState();
}

class _XraysState extends State<Xrays> {
  @override
  Widget build(BuildContext context) {
    //set url to correct db link for case:
    int id = widget.caseID;
    String url = "https://xrayimagesresp2.s3.amazonaws.com/";
    url = url + id.toString() + ".jpg";
    print(url);
    NetworkImage(url);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xray Results'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
