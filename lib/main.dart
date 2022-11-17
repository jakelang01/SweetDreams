import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/views/dreams_input.dart';
import 'dreams/views/dreams_healthy_habits.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dreams/views/dreams_output.dart';
import 'dreams/views/dreams_videos.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dailyMessage = "";
  final messageDB = FirebaseFirestore.instance.collection('Admin');

  void initState() {
    super.initState();
    getMOTD();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sweet Dreams"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("Sweet Dreams!",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
              ),
              Text("Message of the Day:",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline2,
                textAlign: TextAlign.center,
              ),
              Text(dailyMessage,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
              ),
            ],
          )
      ),
      drawer: HamburgerDir(),
    );
  }

  Future<void> getMOTD() async {
    DocumentSnapshot data =  await messageDB.doc("Message of the Day").get();
    setState(() {
      dailyMessage = data.get("motd");
    });
  }

  Future<void> updateMOTD(String newMessage) async {
    // set up map for data to be inputted into Message Of The Day Document
    final newEntry = <String, String>{
      "motd": newMessage,
    };
    // edit Message of the Day Document with new Message of the Day
    await messageDB.doc("Message of the Day").set(newEntry);
    // update Message of the Day in the app screen
    getMOTD();
  }

  Future<void> _updateMOTDDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Input MOTD"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a new Message of the Day'
                  ),
                  onSubmitted: (String text) async {
                    updateMOTD(text);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  // method to check password taken from https://stackoverflow.com/questions/56186457/how-to-hash-value-in-flutter-using-sha256
  Future<bool> checkAdminPassword(String password) async {
    // constant salt for now - vary based on username?
    var saltValue = 'sleepyTime';
    // utf8 representation of string
    var localSaltedPasswordBytes = utf8.encode(password + saltValue);
    // hashed string
    var localSaltedPasswordDigest = sha256.convert(localSaltedPasswordBytes);
    // hashed password in database
    var data =  await messageDB.doc("Account").get();
    var databasePassword = data.get("password");
    if (localSaltedPasswordDigest == databasePassword)
      return true;
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("couldn't connect");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Sweet Dreams',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.deepPurple
                ),

                fontFamily: 'Roboto',
                textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                  headline2: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black45,
                  ),
                ),
              ),
              home: const MyHomePage(title: 'Sweet Dreams'),
            );
          }
          Widget loading = MaterialApp();
          return loading;
        }
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new HomePage(new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}

class HealthyHabitsScreen extends StatefulWidget {
  @override
  _HealthyHabitsScreen createState() => _HealthyHabitsScreen();
}

class _HealthyHabitsScreen extends State<HealthyHabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return new HealthyHabits(title: 'Sweet Dreams', key: Key("Healthy Habits"),);
  }
}

class HamburgerDir extends StatelessWidget {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Future<void> LoginBox(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log In:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(title: Text('Admin Sign In'), onTap: (){
            LoginBox(context);
          }),
          ListTile(title: Text('Sleep Calculator'), onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SplashScreen();
                    }));
          }),
          ListTile(title: Text('Log Last Night\'s Sleep'), onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return InputScreen();
                    }));
          }),
          ListTile(title: Text('See Previous Night\'s Sleep'), onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return OutputScreen();
                    }));
          }),
          ListTile(title: Text('Healthy Sleep Habits'), onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HealthyHabitsScreen();
                    }));
          }),
          ListTile(title: Text('Healthy Sleep Videos'), onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SleepVideosPage(title: 'videos', key: Key("videos"));
                    }));
          }),
        ],
      ),
    );
  }

  Future<dynamic> _navPush(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(
      builder: (context) => page,
    ));
  }
}
