import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:RESP2/userData.dart';

import 'dart:io' show Platform;

bool isAuth = false;
DatabaseReference leaderboardRef;
User user;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
// defines base url to which case no. can be appended:
String baseCaseUrl =
    'https://diagnostic-gamification-api.herokuapp.com/v1/cases/';

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount == null) {
    return null;
  }
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final FirebaseApp app = await Firebase.initializeApp(
      // name: 'db',
      options: Platform.isIOS
          ? FirebaseOptions(
              // ios stuff
              appId: '1:710337551246:ios:f1db02542500a9ea2a22df',
              apiKey: 'AIzaSyA1NYKuXCNd_6zq8YbctrA-uiHbNYwjrM4',
              projectId: 'flutter-firebase-plugins',
              messagingSenderId: '710337551246',
              databaseURL: 'https://the-lung-doctor.firebaseio.com/')
          : FirebaseOptions(
              // android stuff
              appId: '1:710337551246:android:f483bac498cbd8242a22df',
              apiKey: 'AIzaSyA1NYKuXCNd_6zq8YbctrA-uiHbNYwjrM4',
              messagingSenderId: '710337551246',
              projectId: 'flutter-firebase-plugins',
              databaseURL: 'https://the-lung-doctor.firebaseio.com/'));
  final database = FirebaseDatabase(
      app: app, databaseURL: 'https://the-lung-doctor.firebaseio.com/');

  leaderboardRef = database.reference().child('leaderboard');

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoURL != null);
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);
  print(currentUser);
  print(user.email);

  createUser(name, user.email);
  isAuth = true;
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
