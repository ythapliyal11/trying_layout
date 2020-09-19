import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Secondscreen extends StatefulWidget {
  @override
  _SecondscreenState createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {

  //We got this video player from pub.dev. It is called video_player 0.10.12+2
  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('assets/video/Flutter.mp4');
    _videoPlayerController.initialize().then((value) {
      setState(() {
      });
    });
    _videoPlayerController.pause();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        //this is the App Bar, this is standard part of the SCAFFOLD and comes by itself
          title: Text("Second Screen"),
          //added this to the app bar for signout. Used flatbutton as it has transperant background and will blend in to the app bar
          actions: [
            if(FirebaseAuth.instance.currentUser != null)
              FlatButton(child: Text('Sign Out'), onPressed: () => FirebaseAuth.instance.signOut())
            else
              Container() // put empty container whenever you have nothing else to put in a the 'else' part of a IF.
          ],
          centerTitle: true,
          backgroundColor: Colors.red[600]),
      body:          Column(
        children: [
          if (_videoPlayerController.value.initialized)
            AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController)) else CircularProgressIndicator(),
          FlatButton(child: Text('Play/Pause'),
            onPressed: () {
              setState(() {
                if (_videoPlayerController.value.isPlaying)
                  _videoPlayerController.pause();
                else
                  _videoPlayerController.play();
              });
            },)],
      ),

    );
  }
}
