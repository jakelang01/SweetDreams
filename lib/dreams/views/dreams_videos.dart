import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SleepVideosPage extends StatefulWidget {

  SleepVideosPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SleepVideosPageState createState() => _SleepVideosPageState();
}

class _SleepVideosPageState extends State<SleepVideosPage> {

  late YoutubePlayerController controller1;
  final databaseReference = FirebaseFirestore.instance.collection('Admin');
  late String id1;

  void getVideoID() async {
    DocumentSnapshot data =  await databaseReference.doc("Videos").get();
    id1 = data.get("id1");
    setState(() {
      controller1 = YoutubePlayerController(
        initialVideoId: id1,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
    });
  }


  void initState() {
    super.initState();
    getVideoID();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Video Resources'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            Text("Mayo Clinic - Healthy Sleep",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline2,
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            YoutubePlayer(
              controller: controller1,
              showVideoProgressIndicator: true,
            ),
          ],
        )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}