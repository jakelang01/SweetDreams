import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/views/dreams_input.dart';
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
                                  child: Text('Begin'),
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
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
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
     //crossAxisAlignment: CrossAxisAlignment.start,
      body: Column(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "How was your sleep?",
              ),
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
      ],
      ),
    );
  }
  //return new SleepInput(title: 'Sweet Dreams', key: Key("INPUT"),);
}

class TextEntryBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'How was your sleep?',
            ),
          ),
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
      ],
    );
  }
}
/*
class RatingBar extends StatefulWidget {
  @override
  _RatingBar createState() => _RatingBar();
}

class _RatingBar extends State<RatingBar>{
  //const RatingBar({super.key});
  
  @override
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}*/