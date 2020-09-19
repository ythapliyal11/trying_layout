import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

/*
We created this file to make a class for musicplayer that has to be displayed on the main screen.
In flutter (as in other languages), we do not write all the code on the same page else it will become unreadable.
So we created this dart file to make the Music player class (we can call it a custom widget that we created) and then
we use this widget in the home.dart file to show the music player functionality.
There is no inbuilt music player in Flutter, so we searched and got this from pub.dev website (which is a repository of flutter libraries)
 */

class Musicplayer extends StatelessWidget {
  final assetsAudioPlayer = AssetsAudioPlayer();  //This line is mentioned in the documentation available at https://pub.dev/packages/assets_audio_player. 'final' means this variable cannot be reassigned any other value.

  @override //means the below constructor will override the default constructor of statelessWidget. Could we have used stateful widget instead of stateless
  Widget build(BuildContext context) {  //This is the 'build' method which always get called when we make a stateless widget. It comes automatically when the class is constructed
    return Container( //we are returning a container, this container has the buttons and its function which we need to return to anyone who calls this custom Widget
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,  //container can have only one child, we put a row under it so we can have many children like play button or next button
        children: [  //from here starts the children of the Row, which is 2 buttons and a sizedbox between them to keep them seperated.
          RaisedButton(onPressed: () => playmusic(), child: Text('Play/Pause')), // here we have a raisedbutton and onpress we call the playmusic function, it also has a child Text Widget to show the text of the button
          SizedBox(width: 10),
          RaisedButton(onPressed: () => nextsong(), child: Text('Next Song'))  //same concept here, we call the nextsong function
        ],
      ),
    );
  }


  /*
  playmusic gets called when the play/pause button is pressed. It checks if the playlist is populated,
  if empty, it creates the playlist specified and we have added loopmode
  and shownotification options (showNotifications shows the player in the phone's pulldown menu).
  I see that 'assetsAudioPlayer.playOrPause();' is not in the IF part and is only in the ELSE, so
  probably 'assetsAudioPlayer.open' has it by default
   */
  playmusic() {
    if (assetsAudioPlayer.playlist == null) {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio('assets/music/song1.mp3'),
            Audio('assets/music/song2.mp3'),
            Audio('assets/music/song3.mp3')
          ]),
          loopMode: LoopMode.playlist, //loop the full playlist
          showNotification: true);
    }
      else {
        assetsAudioPlayer.playOrPause();
    }

    } //playmusic method


/*
This is called when 'next song' button is pressed.
Here we just use the next() method (prebuilt) to the 'assetAudioPlayer' object of 'AssetsAudioPlayer' class
 */
  nextsong() {
    assetsAudioPlayer.next();
  }
  } // musicplayer class
