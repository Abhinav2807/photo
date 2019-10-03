import 'dart:async';

import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo/dashboard.dart';
import 'package:photo/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Photo",
      home: MyHomePage(title: 'Photo'),
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.yellow[200],
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
            )),
      ),
      routes: {
        Dashboard.dashboardroute:(ctx)=>Dashboard(),
        "/home":(ctx)=>MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;

  FirebaseUser _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }
  // int r=0;

  @override
  Widget build(BuildContext context) {
    //  r=ModalRoute.of(context).settings.arguments as int;
    if (_currentUser == null) {
      // signOutProviders();
      return SignInScreen(
        title: "PhotoFlip",
        header: Column(children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            "PhotoFlip",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 70,
              fontFamily: 'Lobster',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Keep Flipping ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 30,
              fontFamily: 'Lobster',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 350,
          )
        ]),
        showBar: false,
        bottomPadding: 5,
        avoidBottomInset: true,
        color: Colors.orange,
        providers: [ProvidersTypes.facebook],
        twitterConsumerSecret: "",
        twitterConsumerKey: "",
        horizontalPadding: 12,
      );
    } else {
      return HomePage(user: _currentUser);
    }
  }

  void checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }
}

class HomeScreen extends StatelessWidget {
  FirebaseUser user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        elevation: 4.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: signOutProviders,
          )
        ],
      ),
      body: Card(
        child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  child: Image.network(user.photoUrl),
                  backgroundColor: Colors.transparent,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Welcome" + user.displayName ?? user.email,
                    style: TextStyle(fontSize: 20.0, color: Colors.lightBlue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
