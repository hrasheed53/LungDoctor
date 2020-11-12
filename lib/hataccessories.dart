import 'package:flutter/material.dart';
import 'store.dart';

String currentImage = 'assets/images/alien.png';
String newImage = '';

class simpAccessories extends StatefulWidget {
  simpAccessories({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _simpAccessoriesState createState() => _simpAccessoriesState();
}

class _simpAccessoriesState extends State<simpAccessories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Accessories customization"),
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            Stack(children: <Widget>[
              Image.asset(currentImage,
              fit: BoxFit.cover,
              scale: 4.5,),
              if (newImage == 'assets/images/alien_hat1.png') Image.asset(newImage,
              fit: BoxFit.cover,
              scale: 5,),
              if (newImage == 'assets/images/alien_hat2.png') Image.asset(newImage,
              fit: BoxFit.cover,
              scale: 4,),
              if (newImage == 'assets/images/alien_flowercrown.png') Image.asset(newImage,
              fit: BoxFit.cover,
              scale: 4.5,),
              if (newImage == 'assets/images/alien_flowers.png') Image.asset(newImage,
              fit: BoxFit.cover,
              scale: 4,)
            ],),
            // Container(
            //   child: Image.asset(currentImage,
            //   fit: BoxFit.cover,
            //   scale: 4.5,)
            // ),
            // if (newImage != '') Container(
            //   child: Image.asset(newImage,
            //   fit: BoxFit.cover,
            //   scale: 4.5,
            // ),),
            Row(children: <Widget> [
              Container(
                height: 50,
                width: 100,
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {newImage = 'assets/images/alien_hat1.png';});
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Hat 1",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                Container(
                  height: 50,
                  width: 100,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {newImage = 'assets/images/alien_hat2.png';});
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Hat 2",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 130,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {newImage = 'assets/images/alien_flowercrown.png';});
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Flowers",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ],),
                Row(children: <Widget>[
                Container(
                  height: 50,
                  width: 130,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {newImage = 'assets/images/alien_flowers.png';});
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Flowers 2",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ]),
            Row(children: <Widget>[
            Container(
              height: 50,
              width: 350,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                margin: EdgeInsets.all(8.0),
                color: Colors.blue[600],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Store(),
                    ));
                  },
                  splashColor: Colors.grey[600],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Save",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ],),
          ],
        ),
        ),
      ); //   <-- image
  }
}