import 'package:firebase_core/firebase_core.dart'; //have to import this for Firebase to work
import 'package:flutter/material.dart';
import 'package:trying_layout/splashscreen.dart';
import 'home.dart';

/*
Earlier we had a arrow function here which called the Splashscreen. something like below (I have included the old comment too)
-----------------
 //IMPORTANT: usually we have the home class mentioned here, but we have used Splashscreen class here because we
      //wanted to show a splash screen (some image before the app loads) before the app loads. The Splashscreen class
      //then loads the home screen after a delay that we has specified.
void main() => runApp(MaterialApp(home: Splashscreen()));
----------------------------------------------
But now as we have included firebase we had to make it into a asyncronous function and add 2 standard lines as recommended by
google. Also we have changed the Arrow function to the longer variety.

 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();    //required for firebase
  await Firebase.initializeApp();               //required by firebase to initialize firebase in app
  runApp(  // from now and below is standard code
    MaterialApp(
      //IMPORTANT: usually we have the home class mentioned here, but we have used Splashscreen class here because we
      //wanted to show a splash screen (some image before the app loads) before the app loads. The Splashscreen class
      //then loads the home screen after a delay that we has specified.
      home: Splashscreen(),
    ),
  );
}

