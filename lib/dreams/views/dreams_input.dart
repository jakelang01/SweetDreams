import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'package:intl/intl.dart';


class InputScreen extends StatefulWidget {
  @override
  _InputScreen createState() => _InputScreen();
}

class _InputScreen extends State<InputScreen> {
  //date for app bar
  String formattedDate = new DateFormat('LLL d, yyyy').format(new DateTime.now());

  //ratingbar vars
  late final _ratingController;
  late double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData? _selectedIcon;

  //text controllers
  TextEditingController userDescription = TextEditingController();
  TextEditingController wentToSleep = TextEditingController();
  TextEditingController wokeUp = TextEditingController();

  //for handleNewDay
  int count = 1;
  RecordNewNight night = new RecordNewNight();

  //everytime function called firebase document "day" will increment by 1
  //createDay is in presenter and adds data to the collection "Sleep Hours"
  //need a button on this page so that this function can listen
  void handleNewDay(String bedtime, int quality, String wakeUp, String description){
    night.createNight(count, bedtime, quality, wakeUp, description);
    count++;
  }

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  Future<void> _confirmedBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submitted!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your data has been submitted.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        title: Text(formattedDate),
        actions: <Widget>[],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 60.0),
        color: Theme.of(context).canvasColor,
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'How was your sleep?',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.3,
                  style: Theme.of(context).textTheme.headline2,
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: userDescription,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor)),
                  labelText: 'Tell us about your sleep here',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  floatingLabelStyle: Theme.of(context).textTheme.bodyText1
                  //minLines: 1,
                  //maxLines: null,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'Rate your sleep 1-5 Stars',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 0.9,
                  style: Theme.of(context).textTheme.headline2,
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                alignment: Alignment.center,
                child: _ratingBar(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:Text(
                  'When did you fall asleep?',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 0.9,
                  style: Theme.of(context).textTheme.headline2,
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:TextField(
                  controller: wentToSleep, //editing controller of this TextField
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor)),
                      icon: Icon(Icons.timer), //icon of text field
                      labelText: "Went To Sleep At",
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      floatingLabelStyle: Theme.of(context).textTheme.bodyText1,//label text of field
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime =  await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        wentToSleep.text = formattedTime; //set the value of text field.
                      });
                    }
                    else{
                      print("Time is not selected");
                    }
                  },
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:Text(
                  'And when did you wake up?',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 0.9,
                  style: Theme.of(context).textTheme.headline2,
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:TextField(
                  controller: wokeUp, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.timer), //icon of text field
                      labelText: "Woke Up At" , //label text of field
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor)),
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime =  await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        wokeUp.text = formattedTime; //set the value of text field.
                      });
                    }
                    else{
                      print("Time is not selected");
                    }
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
              child:ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  _confirmedBox();
                  handleNewDay(wentToSleep.text, _userRating.toInt(), wokeUp.text, userDescription.text);
                  wentToSleep.dispose();
                  wokeUp.dispose();
                  userDescription.dispose();
                  //Navigator.of(context).popUntil((route) => false);
                },
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(){
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: false,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
          print(_rating);
        });
      },
      updateOnDrag: true,
    );
  }
}