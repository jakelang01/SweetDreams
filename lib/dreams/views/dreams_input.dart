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
  //temp count-starting at because of sample at day 1
  int count = 2;
  RecordNewDay day = new RecordNewDay();
  @override
  void initState() {
    super.initState();
  }

  final databaseReference = FirebaseFirestore.instance.collection('User 1');
  final String addNightButton = "Add Night";
  int nights = 1; // incrementer for nightly data

  void addNight(String bedtime, String wakeUp, double sleepHours, int rating) {
    databaseReference.doc("Night" + nights.toString()).set({"Bedtime": bedtime, "Wake Up": wakeUp, "Hours Slept": sleepHours, "Rating": rating});
    nights++; // increments night for next call
  }

  Future<void> getNightData() async { // need to add user choosing which night's data
    DocumentSnapshot data = await retrieveData();
    print(data.data().toString());
  }

  Future<DocumentSnapshot> retrieveData() async {
    return databaseReference.doc(nights.toString()).get();
  }

  void removeNight() { // need to add user choosing a specific night to delete
    databaseReference.doc(nights.toString()).delete();
  }

  //everytime function called firebase document "day" will increment by 1
  //creaetDay is in presenter and adds data to the collection "Sleep Hours"
  //need a button on this page so that this function can listen
  void handleNewDay(String bedtime, int quality, String wakeUp){
    day.createDay(count, bedtime, quality, wakeUp);
    count++;
  }
//removes specific day from collection specific day number as parameter
  void deleteDay(int collectionDay){
    day.removeDay(collectionDay);
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
