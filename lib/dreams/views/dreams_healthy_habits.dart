import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import'./dreams_videos.dart';

class HealthyHabits extends StatefulWidget {

  HealthyHabits({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HealthyHabitsPageState createState() => _HealthyHabitsPageState();
}

class _HealthyHabitsPageState extends State<HealthyHabits> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Healthy Sleep Habits'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFF000000),
                    width: 2
                  ),
                ),
              ),
                child: Text(
                  "healthy habits go here - this can be a scalable and scrollable list",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.75,
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent
              ),
              child: Text('Video Resources'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return VideosScreen();
                        }));
              },
            ),
          ],
        )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreen createState() => _VideosScreen();
}

class _VideosScreen extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return new SleepVideosPage(title: 'Sweet Dreams', key: Key("VIDEOS"),);
  }
}