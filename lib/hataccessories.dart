import 'package:flutter/material.dart';
//import 'store.dart';

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
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  currentImage,
                  fit: BoxFit.cover,
                  scale: 4.5,
                ),
                if (newImage == 'assets/images/alien_hat1.png')
                  Image.asset(
                    newImage,
                    fit: BoxFit.cover,
                    scale: 5,
                  ),
                if (newImage == 'assets/images/alien_hat2.png')
                  Image.asset(
                    newImage,
                    fit: BoxFit.cover,
                    scale: 4,
                  ),
                if (newImage == 'assets/images/alien_flowercrown.png')
                  Image.asset(
                    newImage,
                    fit: BoxFit.cover,
                    scale: 4.5,
                  ),
                if (newImage == 'assets/images/alien_flowers.png')
                  Image.asset(
                    newImage,
                    fit: BoxFit.cover,
                    scale: 4,
                  )
              ],
            ),
            Row(
              children: <Widget>[
                buttonHelper("Hat 1", "alien_hat1.png"),
                buttonHelper("Hat 2", "alien_hat2.png"),
              ],
            ),
            Row(children: <Widget>[
              buttonHelper("Flowers", "alien_flowercrown.png"),
              buttonHelper("Flowers 2", "alien_flowers.png"),
            ]),
          ],
        ),
      ),
    ); //   <-- image
  }

  Widget buttonHelper(name, filename) {
    return Container(
      height: 50,
      width: 130,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              newImage = 'assets/images/' + filename;
            });
          },
          splashColor: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
