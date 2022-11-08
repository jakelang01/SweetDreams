import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/views/dreams_input.dart';
import 'dreams/views/dreams_healthy_habits.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // check for errors
        if (snapshot.hasError) {
          print("couldn't connect");
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              home: Builder(
                  builder: (context) =>
                      Scaffold(
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
                                  child: Text('Add Sleep Data'),
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
                              ],
                            )
                        ),
                      )
              )
          );
        }
      Widget loading = MaterialApp();
      return loading;
  });
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

class InputScreen extends StatefulWidget {
  @override
  _InputScreen createState() => _InputScreen();
}

class _InputScreen extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 64),
            child: Text(
              'How was your sleep?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Tell us about your sleep here',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            'Rate your sleep 1-5 Stars',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1.8,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ),
      ],
    ),
    );
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

/*
class RatingBar extends StatelessWidget{
  const RatingBar({super.key});


  Widget _ratingBar(){
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: false,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating){
        setState((){
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
*/