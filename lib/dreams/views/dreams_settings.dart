import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import '../../main.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          //backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        //backgroundColor: Colors.white,
        body: Center(child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Light Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Dark Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    },
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(5.0)),
          ],
        )
    ));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}