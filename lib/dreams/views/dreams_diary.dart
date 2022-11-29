import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'package:intl/intl.dart';

typedef void CaffCallback(int c);

class DiaryScreen extends StatefulWidget {
  //const DiaryScreen({Key key, required this.caffKey}) : super(key: key);
  //final int caffKey;

  @override
  _DiaryScreen createState() => _DiaryScreen();
}

String caffDrop = '';

class _DiaryScreen extends State<DiaryScreen> {

  //text controllers
  TextEditingController dailyEntry = TextEditingController();

  int dailyCaf = 0;
  //late int localCaf;

  @override
  void initState() {
    //localCaf = widget.caffKey;
    super.initState();
  }

  /*final CaffCallback onChanged;
  _DiaryScreen({required this.onChanged});
  onChanged: (int updCaff){
  updateCaff(updCaff)
  }
  void updateCaff(int up){
    setState(() {
      up = dailyCaf;
    });
  }*/

  void calcCaff(String dropValue){
    switch(dropValue){
      case 'Coffee':{
        dailyCaf += 95;
      }
      break;
      case 'Espresso':{
        dailyCaf += 64;
      }
      break;
      case 'Monster':{
        dailyCaf += 160;
      }
      break;
      case 'Redbull':{
        dailyCaf += 111;
      }
      break;
      default: break;
    }
  }

  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        title: Text("Daily Diary"),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                'Tell Us About Your Day',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.5,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: dailyEntry,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "How was your day?",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              'What kind of caffeine did you consume?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: CaffeineMenu(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple
              ),
              child: Text('Confirm'),
              onPressed: () {
                calcCaff(caffDrop);
                setState(() {
                  Object redrawObject = Object();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              'Total Caffeine Today: $dailyCaf',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.5,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          )
        ],
      ),
    );
  }


}

const List<String> list = <String>['Coffee', 'Espresso', 'Monster', 'Redbull',];

class CaffeineMenu extends StatefulWidget {
  const CaffeineMenu({super.key});

  @override
  State<CaffeineMenu> createState() => _CaffeineMenu();
}

class _CaffeineMenu extends State<CaffeineMenu> {

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          caffDrop = dropdownValue;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}