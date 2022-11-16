import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'dreams_videos.dart';

class HealthyHabits extends StatefulWidget {

  HealthyHabits({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HealthyHabitsPageState createState() => _HealthyHabitsPageState();
}

class _HealthyHabitsPageState extends State<HealthyHabits> {

  @override
  void initState() {
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Healthy Sleep Habits'),
       centerTitle: true,
       backgroundColor: Colors.purpleAccent.shade700,
     ),
     backgroundColor: Colors.white,
     body: SingleChildScrollView(
       child: Column(
           children: [
             Container(
               decoration: BoxDecoration(
                 color: Colors.purple,
                 border: Border(
                   bottom: BorderSide(
                     color: Colors.white,
                     width: 2,
                   ),
                 ),
               ),
               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
               child: Text(
                 'People ages 18-70 should be getting at least 7 or more hours of sleep per night.',
                     style: TextStyle(fontSize: 24, color: Colors.white),
                     maxLines: 3,
               ),
             ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.purple,
                 border: Border(
                   bottom: BorderSide(
                    color: Colors.white,
                      width: 2),
                 ),
               ),
               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
               child: Text(
                 'The best sleep habit you could make for yourself is making sure the times you wake up and go to bed are consistent each day.',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    maxLines: 3,
                 ),
               ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.purple,
                 border: Border(
                   bottom: BorderSide(
                     color: Colors.white,
                     width: 2,
                   ),
                 ),
               ),
               padding:  EdgeInsets.fromLTRB(20, 20, 20, 20),
               child: Text(
                 'Try your best to stay away from caffeine, large meals, and alcohol about 2 hours or more before you head to bed.',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    maxLines: 3,
               ),
             ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.purple,
                 border: Border(
                   bottom: BorderSide(
                     color: Colors.white,
                     width: 2,
                   ),
                 ),
               ),
               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
               child: Text(
                 'If you find yourself struggling to fall asleep at night, try including some exercise in your daily routine.',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    maxLines: 3,
               ),
             ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.purple,
                 border: Border(
                   bottom: BorderSide(
                     color: Colors.white,
                     width: 2
                   ),
                 ),
               ),
               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
               child: Text(
                 'Whatever sleep habit I also have to add idk yet',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    maxLines: 3,
               ),
             ),
             ElevatedButton(
               child: Text('Video Resources'),
               onPressed: () {
                 Navigator.of(context).push(
                     MaterialPageRoute(
                         builder: (BuildContext context) {
                           return SleepVideosPage(title: 'videos', key: Key("videos"));
                         }));
               },
             ),
           ] // Children
       ),
     ),
   );
 }

   _fieldFocusChange(BuildContext context, FocusNode currentFocus,
       FocusNode nextFocus) {
     currentFocus.unfocus();
     FocusScope.of(context).requestFocus(nextFocus);
   }
 }

