import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'beginningGame.dart';
import 'signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginFields(title: 'Login Page'),
    );
  }
}

class LoginFields extends StatefulWidget {
  LoginFields({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue[600],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            // need to have some kind of check here to see if signInWithGoogle
            // returns a null, aka they cancelled sign in
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Instr();
                },
              ),
            );
          });
          /*var signIn = signInWithGoogle();
          if (signIn != Null) {
            signInWithGoogle().whenComplete(() {
              // need to have some kind of check here to see if signInWithGoogle
              // returns a null, aka they cancelled sign in
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Instr();
                  },
                ),
              );
            });
          } else {}*/
        },
        child: Text("Sign in with Google",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.lightBlue[100]])),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/doctorthing.png",
                    fit: BoxFit.contain,
                  ),
                ),
                /*SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,*/
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
