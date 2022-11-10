import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SleepVideosPage extends StatefulWidget {

  SleepVideosPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SleepVideosPageState createState() => _SleepVideosPageState();
}

class _SleepVideosPageState extends State<SleepVideosPage> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Healthy Habits: Video Resources'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            Text("Do stuff here"),
            Padding(padding: EdgeInsets.all(5.0)),
          ],
        )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}