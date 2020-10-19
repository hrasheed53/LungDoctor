import 'package:flutter/material.dart';
import 'navBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'gamePlay.dart';
import 'leaderboard.dart';
import 'settings.dart';
import 'store.dart';


class QA extends StatefulWidget {
  QA({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QAState createState() => _QAState();
}

class _QAState extends State<QA> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explanations'),
      ),
      body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.lightBlue[100]])),
        child: ListTile(
              title: Text(
                "Common Questions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.left,
              ),
              subtitle: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(text:'What is the Sabatoge Man \n', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        TextSpan(text:'He is a man that will randomly pop up and give a suggestion for the diagnosis. Sometimes he will give you a correct answer and sometimes he will give you a wrong answer. ', style: TextStyle(fontSize: 14),),
                        TextSpan(text: 'It is your job as the doctor to decide if he is correct. You will get more points for answering a question when he has given a suggestion', style: TextStyle(fontSize: 14),),
                        TextSpan(text: '. He will never give wrong reasoning so you will not become confused, however if you do not want him to be a distraction to you we recommend you turn it off.', style: TextStyle(fontSize: 14),),
                        TextSpan(text: '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'),
                      ],
                  ),
                ),
              ),
          ),
            ),),
      ),
      bottomNavigationBar: navBar(),
    );
    }
  }