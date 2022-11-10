import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/views/dreams_input.dart';
import 'dreams/views/dreams_healthy_habits.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dreams/views/dreams_output.dart';

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
  final messageDB = FirebaseFirestore.instance.collection('Messages');

  Future<void> getMOTD() async {
    DocumentSnapshot data =  await messageDB.doc("MOTD").get();
    String unformatted = data.data().toString();
    setState(() {
      dailyMessage = unformatted.substring(9,unformatted.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dailyMessage == "") getMOTD();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sweet Dreams"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0,
                    bottom: 20.0),
                child: Text("Sweet Dreams!",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                  textScaleFactor: 3,)
                ,),
              Text("Message of the Day:",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textScaleFactor: 1.7,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(dailyMessage,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey),
                  textScaleFactor: 1.3,)
                ,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('Sleep Calculator'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SplashScreen();
                          }));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('Last Night\'s Sleep'), // better way to phrase this?
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return InputScreen();
                          }));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('Healthy Sleep Habits'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HealthyHabitsScreen();
                          }));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('motd test'),
                onPressed: getMOTD,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('See Previous Night\'s Sleep'), // better way to phrase this?
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return OutputScreen();
                          }));
                },
              ),
            ],
          )
      ),
    );
  }}

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
              title: 'Flutter Demo',
              theme: ThemeData(

                primarySwatch: Colors.blue,
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

