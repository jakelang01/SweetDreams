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
  late YoutubePlayerController controller2;
  late YoutubePlayerController controller3;
  final databaseReference = FirebaseFirestore.instance.collection('Admin');
  late String id1;
  String header1 = "";
  late String id2;
  String header2 = "";
  late String id3;
  String header3 = "";

  YoutubePlayerController createController(String id) {
    return YoutubePlayerController(
      initialVideoId: id,
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
  }

  void getVideoID() async {
    DocumentSnapshot data =  await databaseReference.doc("Videos").get();
    id1 = data.get("id1");
    id2 = data.get("id2");
    id3 = data.get("id3");
    setState(() {
      header1 = data.get("header1");
      header2 = data.get("header2");
      header3 = data.get("header3");
      controller1 = createController(id1);
      controller2 = createController(id2);
      controller3 = createController(id3);
    });
  }

  Widget createPlayer(YoutubePlayerController controller, String header) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(header,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
        ),
        YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        ),
      ],
    );
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
        //backgroundColor: Theme.of(context).backgroundColor, // this breaks everything for some reason
        body: ListView(
          children: <Widget>[
            createPlayer(controller1, header1),
            createPlayer(controller2, header2),
            createPlayer(controller3, header3),
          ],
        )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}