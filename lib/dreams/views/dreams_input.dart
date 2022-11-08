import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';

class SleepInput extends StatefulWidget {

  SleepInput({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SleepInputPageState createState() => _SleepInputPageState();
}

class _SleepInputPageState extends State<SleepInput> {
  int count = 1;
  RecordNewNight night = new RecordNewNight();
  @override
  void initState() {
    super.initState();
  }

  //everytime function called firebase document "day" will increment by 1
  //createDay is in presenter and adds data to the collection "Sleep Hours"
  //need a button on this page so that this function can listen
  void handleNewDay(String bedtime, int quality, String wakeUp){
    night.createNight(count, bedtime, quality, wakeUp);
    count++;
  }

  //removes specific day from collection specific day number as parameter
  void deleteDay(int collectionDay){
    night.removeNight(collectionDay);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Last Night\'s Sleep Data'),
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
