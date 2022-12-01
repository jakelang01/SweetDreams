import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';

List<String> list = <String>['Night1', 'Night2', 'Night3', 'Night4'];
String _dropdownValue1 = list.first;
String _dropdownValue2 = list.last;
//String bedTime1 = 'no value';
//String description1 = 'empty';
//int quality1 = 0;
//String totalSleep1 = 'nothing';
//String wakeUp1 = 'something';
final databaseReference = FirebaseFirestore.instance.collection("Example User");

class OutputScreen extends StatefulWidget {
  @override
  _OutputScreen createState() => _OutputScreen();
}

class _OutputScreen extends State<OutputScreen> {

  String bedTime1 = 'no value';
  String description1 = 'empty';
  int quality1 = 0;
  String totalSleep1 = 'nothing';
  String wakeUp1 = 'something';
  String nightNumber = "Night0";

  RecordNewNight night = new RecordNewNight();
  TextEditingController userInput = TextEditingController();

  Future<void> setData(String number) async {
    var bedtime = await getTheBedTime(number);
    var description = await getTheDescription(number);
    var quality = await getTheQuality(number);
    var totalSleep = await getTheTotalSleep(number);
    var wakeUp = await getTheWakeUp(number);

    setState(() {
      nightNumber = number;
      bedTime1 = bedtime;
      description1 = description;
      quality1 = quality;
      totalSleep1 = totalSleep;
      wakeUp1 = wakeUp;
    });
  }

  Future<String> getTheBedTime(String nightNumber) async {
    return night.getBedtime(nightNumber);
  }

  Future<String> getTheDescription(String nightNumber) async {
    return night.getDescription(nightNumber);
  }

  Future<int> getTheQuality(String nightNumber) async {
    return night.getQuality(nightNumber);
  }

  Future<String> getTheTotalSleep(String nightNumber) async {
    return night.getTotalSleep(nightNumber);
  }

  Future<String> getTheWakeUp(String nightNumber) async {
    return night.getWakeUp(nightNumber);
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
        ),
        backgroundColor: Theme.of(context).backgroundColor,
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
                      child:ElevatedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          nightNumber = "Night" + userInput.text;
                          setData(nightNumber);
                        },
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Text(
                      '$nightNumber' + '\nQuality: $quality1' + '\nBedtime: $bedTime1' + '\nWakeUp: $wakeUp1' + '\nTotalSleep: $totalSleep1' + '\nDescription: $description1',
                      textAlign: TextAlign.center,
                      //overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.9,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ]
        )
    );
  }
}

