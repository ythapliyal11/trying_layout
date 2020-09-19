import 'package:flutter/material.dart';
import 'home.dart';

/*
Our main.dart file calls this class, we created this class to show a logo for 3 seconds before the app loads.
Logic: in the scaffold, we are showing a image as a child, but just below 'Widget build' line, we have called
a method 'navigatetohome(context)' (just like a function. Functions are defined after the class and methods are defined inside a class)
Here we have used the 'Future' utility to pause for 3 seconds and then redirect to Home screen.
While we are waiting 3 seconds, the parser continues to the next line and loads the image. The image stays on the screen
for 3 seconds. If we had a large application to load, we would not have had to specify a 3 second delay as the app would have anyway required that much time to load.
 */

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    navigatetohome(context); // method call

    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('assets/splashgsu.png', height: 200, width: 200),
          ),
        )
    );
  }

  void navigatetohome(BuildContext context) {
    Future.delayed(Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder: (context) => Home())));
  }
}
