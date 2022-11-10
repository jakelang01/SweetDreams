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
      body: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              child: Text(
                'How was your sleep?',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: TextFormField(
              controller: userDescription,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tell us about your sleep here',
                //minLines: 1,
                //maxLines: null,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                'Rate your sleep 1-5 Stars',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.8,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child:Text(
                'When did you fall asleep? And when did you wake up?',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child:TextField(
                controller: wentToSleep, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText: "Went To Sleep At" //label text of field
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
              child:TextField(
                controller: wokeUp, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText: "Woke Up At" //label text of field
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent
              ),
              child: Text('Submit'),
              onPressed: () {
                handleNewDay(wentToSleep.text, _userRating.toInt(), wokeUp.text, userDescription.text);
                wentToSleep.dispose();
                wokeUp.dispose();
                userDescription.dispose();
                Navigator.of(context).pop(false);
              },
            )
          )
        ],
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
        });
      },
      updateOnDrag: true,
    );
  }
}

/*
class SleepInput extends StatefulWidget {

  SleepInput({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SleepInputPageState createState() => _SleepInputPageState();
}

class _SleepInputPageState extends State<SleepInput> {
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
*/
