import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';

List<String> list = <String>['Night1', 'Night2', 'Night3', 'Night4'];
String _dropdownValue1 = list.first;
String _dropdownValue2 = list.last;
String bedTime1 = 'no value';

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
          backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Colors.white,
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
                      getTheBedTime(_dropdownValue1);
                      _dropdownValue1 = newValue!;

                    });
                  }),
            Expanded(
              child: Text(
                bedTime1 + _dropdownValue1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                textScaleFactor: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
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


