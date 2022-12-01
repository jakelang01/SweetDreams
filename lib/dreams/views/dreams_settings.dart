import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import '../../main.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../dreams/utils/dreams_callback_typedefs.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final adminDB = FirebaseFirestore.instance.collection('Admin');
  final messageDB = FirebaseFirestore.instance.collection('Admin');

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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 73),
              child: ElevatedButton(
                child: Text('Admin Options'),

                onPressed: () {
                  LoginBox(context);
                },
              ),
            ),
          ],
        )
    ));
  }

  Future<void> LoginBox(BuildContext context) async {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log In:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () async {
                bool pass = await checkAdminPassword(username.value.text, password.value.text);
                Navigator.of(context).pop(false);
                if (pass){
                  callbackToUpdateMOTD();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateMOTD(String newMessage) async {
    // set up map for data to be inputted into Message Of The Day Document
    final newEntry = <String, String>{
      "motd": newMessage,
    };
    // edit Message of the Day Document with new Message of the Day
    await adminDB.doc("Message of the Day").set(newEntry);
    // update Message of the Day in the app screen
  }

  Future<void> callbackToUpdateMOTD() async {
    await _updateMOTDDialogue();
    if (mounted)
    {
      MyHomePage.of(context).getMOTD();
    }
//    MyApp.of(context).changeTheme(ThemeMode.light);
  }

  Future<void> _updateMOTDDialogue() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Input MOTD"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a new Message of the Day'
                    ),
                    onSubmitted: (String text) async {
                      updateMOTD(text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  // method to check password taken from https://stackoverflow.com/questions/56186457/how-to-hash-value-in-flutter-using-sha256
  Future<bool> checkAdminPassword(String username, String password) async {
    var saltValue = username.length > 0 ? username : '';
    // utf8 representation of string
    //print(password + saltValue);
    var localSaltedPasswordBytes = utf8.encode(password + saltValue);
    // hashed string
    var localSaltedPasswordDigest = sha256.convert(localSaltedPasswordBytes);
    //print(localSaltedPasswordDigest);
    // hashed password in database
    var data = await adminDB.doc("Account").get();
    var databasePassword = data.get("password");
    //print(databasePassword);
    if (localSaltedPasswordDigest.toString() == databasePassword) {
      return true;
    }
    return false;
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}