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

class SleepOutput extends StatefulWidget {

  SleepOutput({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SleepOutputPageState createState() => _SleepOutputPageState();
}

class _SleepOutputPageState extends State<SleepOutput> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('See previous Night\'s Sleep Data'),
          centerTitle: true,
          //backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
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
class OutputScreen extends StatefulWidget {
  @override
  _OutputScreen createState() => _OutputScreen();
}

class _OutputScreen extends State<OutputScreen> {

  RecordNewNight night = new RecordNewNight();

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
          //backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
                children:<Widget>[
                DropdownButton(
                    dropdownColor: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(.5),
                    items: list.map((location){
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                    );
                  }).toList(),
                  value: _dropdownValue1,
                  alignment: AlignmentDirectional.center,
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownValue1 = newValue!;
                      getTheDescription(_dropdownValue1);
                      getTheBedTime(_dropdownValue1);
                      getTheQuality(_dropdownValue1);
                      getTheTotalSleep(_dropdownValue1);
                      getTheWakeUp(_dropdownValue1);
                    });
                  }),
            Expanded(
              child: Text(
                bedTime1 + " " + description1 + " " + quality1.toString()
                + " " + totalSleep1 + ' ' + wakeUp1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline2,
              ),
            )
                ]
        )
    );
  }
}

//for the database reference need future builder
// Expanded(
// child: FutureBuilder<String>(
// future: getTheBedtime(_dropdownValue1),
// builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
// if (snapshot.hasData) {
// Padding(
// padding: const EdgeInsets.only(top: 16),
// child: Text('Result: ${snapshot.data}'),
// );
// }
// return Scaffold(
// body: Text("this is text"),
// );
// })
// )


