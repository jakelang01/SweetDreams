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
              ElevatedButton(
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
                child: Text('Last Night\'s Sleep'),
                // better way to phrase this?
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return InputScreen();
                          }));
                },
              ),
              ElevatedButton(
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
                child: Text('Update MOTD'),
                onPressed: () {
                  updateMOTD("test message - Ethan");
                }
              ),
              ElevatedButton(
                child: Text('See Previous Night\'s Sleep'),
                // better way to phrase this?
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

