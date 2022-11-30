import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:units/dreams/views/dreams_diary.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/views/dreams_input.dart';
import 'dreams/views/dreams_diary.dart';
import 'dreams/views/dreams_healthy_habits.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dreams/views/dreams_output.dart';
import 'dreams/views/dreams_videos.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dreams/utils/dreams_callback_typedefs.dart';
import 'dreams/views/dreams_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static _MyHomePageState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyHomePageState>()!;
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
        title: Text("Chamomile"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 7.0),
              ),
              Text("Lets Help You Sleep",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7.0),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                child: Column(children: <Widget>[
                  Text("Message of the Day:",
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(dailyMessage,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ])
              ),
              Container(
                height: 600,
                width: 800,
                alignment: Alignment.center,
                child:
                  Image.asset('assets/images/sleepycow2.png',
                  fit: BoxFit.cover,
                  ),
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
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.system;

  // dark mode method taken from
  // https://stackoverflow.com/questions/60232070/how-to-implement-dark-mode-and-light-mode-in-flutter
  void changeTheme(ThemeMode newMode) {
    setState(() {
      _themeMode = newMode;
    });
  }

  void rebuildApp() {
    final temp = _themeMode;
    changeTheme(ThemeMode.light);
    changeTheme(ThemeMode.dark);
    changeTheme(temp);
  }

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
                backgroundColor: Colors.white,
                canvasColor: Colors.grey.shade300,
                unselectedWidgetColor: Colors.black,
                dividerColor: Colors.black87,
                scaffoldBackgroundColor: Colors.grey.shade300,

                fontFamily: 'Roboto',
                textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent,
                  ),
                  headline2: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  headline3: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  headline4: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black87,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 18.0,
                    //fontStyle: FontStyle.italic,
                    color: Colors.black45,
                  ),
                  button: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.deepPurple
                ),
                backgroundColor: Colors.white10,
                canvasColor: Colors.grey.shade900,
                unselectedWidgetColor: Colors.white70,
                dividerColor: Colors.deepPurpleAccent,
                scaffoldBackgroundColor: Colors.grey.shade100,

                fontFamily: 'Roboto',
                textTheme: TextTheme(
                  headline1: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent,
                  ),
                  headline2: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                  headline3: TextStyle(
                    fontSize: 24.0,
                    color: Colors.deepPurpleAccent,
                  ),
                  headline4: TextStyle(
                    fontSize: 24.0,
                    color: Colors.deepPurple,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurpleAccent,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 16.0,
                    //fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
                  button: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              themeMode: _themeMode,
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

  // method for flutter data binding taken from: https://medium.com/flutter-community/data-binding-in-flutter-or-passing-data-from-a-child-widget-to-a-parent-widget-4b1c5ffe2114
  // final Callback onCorrectAdminLogin;
  // HamburgerDir({required this.onCorrectAdminLogin});

  final adminDB = FirebaseFirestore.instance.collection('Admin');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text('Sleep Calculator',
              style: Theme.of(context).textTheme.button
              ),
              onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SplashScreen();
                    }));
          }),
          ListTile(title: Text('Log Last Night\'s Sleep', style: Theme.of(context).textTheme.button),
              onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return InputScreen();
                    }));
          }),
          ListTile(title: Text('See Previous Night\'s Sleep', style: Theme.of(context).textTheme.button),
              onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return OutputScreen();
                    }));
          }),
          ListTile(title: Text('Healthy Sleep Habits', style: Theme.of(context).textTheme.button),
              onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HealthyHabitsScreen();
                    }));
          }),
          ListTile(title: Text('Healthy Sleep Videos', style: Theme.of(context).textTheme.button),
              onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SleepVideosPage(title: 'videos', key: Key("videos"));
                    }));
          }),
          /* ListTile(title: Text('Update MOTD', style: Theme.of(context).textTheme.button),
              onTap: (){
            LoginBox(context);
            }), */
          ListTile(title: Text('Daily Diary', style: Theme.of(context).textTheme.button),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DiaryScreen();
                    }));
          }),
          ListTile(title: Text('Settings', style: Theme.of(context).textTheme.button),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SettingsPage(title: 'settings', key: Key("settings"));
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
