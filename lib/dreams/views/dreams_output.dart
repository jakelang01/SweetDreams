import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';

List<String> list = <String>['Night1', 'Night2', 'Night3', 'Night4'];
String _dropdownValue1 = list.first;
String _dropdownValue2 = list.last;
String bedTime1 = 'no value';
String description1 = 'empty';
int quality1 = 0;
String totalSleep1 = 'nothing';
String wakeUp1 = 'something';
final databaseReference = FirebaseFirestore.instance.collection("Example User");

class OutputScreen extends StatefulWidget {
  @override
  _OutputScreen createState() => _OutputScreen();
}

class _OutputScreen extends State<OutputScreen> {

  RecordNewNight night = new RecordNewNight();
  TextEditingController userInput = TextEditingController();

  void setData(String number) {
    getTheBedTime(number);
    getTheDescription(number);
    getTheQuality(number);
    getTheTotalSleep(number);
    getTheWakeUp(number);
  }

  void getTheBedTime(String nightNumber) async {
    Future<String> bedFuture = night.getBedtime(nightNumber);
    bedTime1 = await bedFuture;
  }

  void getTheDescription(String nightNumber) async {
    Future<String> bedFuture = night.getDescription(nightNumber);
    description1 = await bedFuture;
  }

  void getTheQuality(String nightNumber) async {
    Future<int> bedFuture = night.getQuality(nightNumber);
    quality1 = await bedFuture;
  }

  void getTheTotalSleep(String nightNumber) async {
    Future<String> bedFuture = night.getTotalSleep(nightNumber);
    totalSleep1 = await bedFuture;
  }

  void getTheWakeUp(String nightNumber) async {
    Future<String> bedFuture = night.getWakeUp(nightNumber);
    wakeUp1 = await bedFuture;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('See Previous Night\'s Sleep Data'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        body: Column(
                children:<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: userInput,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor)),
                  labelText: 'Number of night you want to view',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyText1
                  //minLines: 1,
                  //maxLines: null,
                ),
              ),
            ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Text("Night" + userInput.text + " " + quality1.toString() + " " + bedTime1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.9,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple
                        ),
                        child: Text('Submit'),
                        onPressed: () => getTheBedTime("Night" + userInput.text)
                      )
                  ),
                ]
        )
    );
  }
}

