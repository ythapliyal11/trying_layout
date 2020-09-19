import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trying_layout/JsonApi.dart';
import 'package:trying_layout/musicplayer.dart';
import 'package:trying_layout/secondscreen.dart';
import 'package:trying_layout/weatherscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trying_layout/Authentication.dart';



import 'FireBase.dart';
import 'FireBaseShowData.dart';
import 'LoginScreen.dart';
import 'VideoPlayerApp.dart';
/*flutter uses widget tree, to acheive any layout, we need to play with widgets.
In this app, we have seperated the class which runs the code in main.dart
and rest of the codes in different dart files
*/

//Home is the name of the class which gets called from main.dart when the app is run, it extends a stateless widget (means values inside them cannot change at runtime)
//Earlier we had made this as stateless widget. Later on as we needed to show/hide one of the weather buttons, we had to make this into a stateful widget.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // we are checking if 'FirebaseAuth.instance.currentUser' is not null or not and assigning it to the variable. If not null then the the value will
  //be true, which means the user is not signed in.
  bool var_checkifsignedIn = FirebaseAuth.instance.currentUser != null;


  @override //means this class will override the default values of the stateless widget
  Widget build(BuildContext context) {
    //don't know what this means, but just use this line everytime
    return Scaffold(
        //seems to be same like scaffold in other languages like groovy and grails, which provides basic structure
        drawer: Drawer(
          //the drawer in gray is the property of scaffold and the Drawer in yellow is ths drawer widget
          child: Container(
            //under drawer we can have one child and we are using a container widget as the child, container is just like <div> tag in HTML, which is just a placeholder in which you can do different things
            color: Colors.lightBlue.withOpacity(.10),
            //color and opacity of the drawer
            width: 100,
            //width of the container, 100 means it is as wide as a drawer
            child: Column(
              //child of the container. Container can only have one child. We used the column widget as child of container and a column can have many children
              children: [
                //children of the column
                DrawerHeader(
                    //drawerheader is first child of column
                    child: Column(
                  //column as child of drawer header (second time we are using column, we did this as we had to show 3 things (header, image and name and email) one below the other in drawerheader, to acheive this placement we had to use this widget under drawerheader
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // 'start' means all children elements of column will start from left
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // space between widgets will be equal
                  children: [
                    // the [ brackets indicate that from now on we will have list of children of this column widget
                    Align(
                      //Align is also a widget, we are wrapping everything in this child in the align widget to ensure the alignment that we want, this align is wraping only the first child of the column, others don't need it in our layout
                      alignment: Alignment.center,
                      //property of the align widget
                      child: Text(
                        //child of align widget, we use the Text widget for this child as we needed to display the word 'menu' in the center.
                        'Menu',
                        style: TextStyle(
                            fontSize:
                                20), // this is a property of Text widget where we can set font, size color etc
                      ),
                    ),
                    // Here is where Align ends
                    Row(
                      // We are using 'Row' as the second child of the column widget, we used row as we wanted to display my image and name next to each other in the drawerheader
                      children: [
                        //row also can have lots of children, in my layout we are using two (image and text)
                        Image.asset('assets/face.png', height: 70, width: 70),
                        //image that will be displayed
                        Text('Name: Yogesh Thapliyal', //my name next to it
                            style: TextStyle(fontSize: 15)),
                        //font for that text and font size
                      ],
                    ),
                    Text('Email: yogesh.techdeveloper@gmail.com',
                        //row has ended above, now we are again in the column which we used as child of drawerheader
                        style: TextStyle(fontSize: 13))
                  ],
                )),
                //drawer header ends here, a faint line will be displayed on the screen
                //We used ListView as another child of column which is directly under drawer (not drawer header), look up ListView in google
                ListView(shrinkWrap: true, children: [
                  //ShrinkWrap limits the height of the ListView to the total of its components. ListView can have many children. It creates a list of many Widgets (its children) which will show in the screen one below the other. A list tile is a tile under a ListView, we have used other widgets like divider as a child too
                  ListTile(
                    onTap: () => _launchURL('https://www.google.com'),
                    //we downloaded _launchurl from pub.dev and imported it in this file, it will help in launching url's, the actual function which takes the url and launches is defined later on in this file
                    title: Text('www.google.com'),
                    subtitle: Text(
                        'Trying out Menu\'s'), // the backslash \ is the escape charector
                  ),
                  Divider(),
                  //divider is just a line for decoration purpose, here it is used as another child of ListView widget
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Secondscreen())),
                    //this is important, here we are having a link in a ListTile widget linking to another screen of our app, I don't know the exact meaning of each word typed there.
                    title: Text('Second Screen'),
                    subtitle: Text('Trying out Menu\'s'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Link 1'),
                    subtitle: Text('Trying out Menu\'s'),
                  ),
                  Divider()
                ])
              ],
            ),
          ),
        ),
        appBar: AppBar(
            //this is the App Bar, this is standard part of the SCAFFOLD and comes by itself
            title: Text("Rashi's fun app"),
            //added this to the app bar for signout. Used flatbutton as it has transperant background and will blend in to the app bar
            actions: [
              if (FirebaseAuth.instance.currentUser != null)
                //we had to add the '.then' and the rest as we had to refresh the page after sign out and also needed to
                //set the 'var_checkifsignedIn' variable to false, as that is later used to show/hide one of the weather buttons.
                FlatButton(
                    child: Text('Sign Out'),
                    onPressed: () =>
                        FirebaseAuth.instance.signOut().then((value) {
                          setState(() {
                            var_checkifsignedIn =
                                FirebaseAuth.instance.currentUser != null;
                          });
                        }))
              else
                Container()
              // put empty container whenever you have nothing else to put in a the 'else' part of a IF.
            ],
            centerTitle: true,
            backgroundColor: Colors.red[600]),
        /*
   The body below is the body of the 'Scafold Widget'.
   As Scafold has only one body and we have to put a lot of things under it, we used the Column Widget and as child of it
   used a row (did all this just so the buttons are placed properly on the screen), in the row we called the 'MusicPlayer()' Widget
   and then we added the 'Weather' button in the same row.
    */
        //'Builder' widget is used as we need the 'context' to be passed while calling the snackbar widget (snackbar displays one time messages)
        //with out builder we cannot pass context and without context being passed, snackbar will not work
        body: Builder(
          builder: (BuildContext context) {
            return Stack(fit: StackFit.expand, children: [
              Image.asset(
                'assets/thunderbackground.jpg',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Musicplayer(),
                      ],
                    ),
                    Row(
                      //this button is not visible if person is not logged in with firebase.
                      children: [
                        if (!var_checkifsignedIn) // if not logged in then the button is not visible. Notice the ! symbol at the start
                          Container()
                        else
                          RaisedButton(
                              child: Text('Weather'),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Weatherscreen()))),
                        RaisedButton(
                            //this button is visible weather I am logged in or not, but checks on press if I am logged in or not.
                            child: Text('Weather'),
                            onPressed: () => gotoweatherornot(context)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FlatButton(
                            //added the srinkwrap to remove any space around the button which was causing the button to not align with the text next to it.
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            color: Colors.lightBlue,
                            //this button was added to the home sceen to go to the pages where we can create account or login
                            child: Text('Create Account'),
                            onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Authentication()))
                                    // the below '.then' code is for setting the variable 'var_checkifsignedIn' to True (which means user is signed in)
                                    //This is needed as the page should know that the user was authenticated
                                    .then((value) {
                                  setState(() {
                                    var_checkifsignedIn =
                                        FirebaseAuth.instance.currentUser !=
                                            null;
                                  });
                                })),
                      ],

                    ),
                    Row(
                      children: [
                        Text(
                          ' Already have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        //gestureDetector is a widget which can handle, taps, double taps and other user interactions like longpress etc
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen()))
                            // the below '.then' code is for setting the variable 'var_checkifsignedIn' to True (which means user is signed in)
                            //This is needed as the page should know that the user was authenticated
                                .then((value) {
                              setState(() {
                                var_checkifsignedIn =
                                    FirebaseAuth.instance.currentUser !=
                                        null;
                              });
                            }),
                            child: Text(' Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoPlayerApp()))
                            ,
                        child: Text(' My Video Player',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                decoration: TextDecoration.underline))),
                    FlatButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FireBase())),
                        label: Text('Go to Firebase Form'), icon: Icon(Icons.save)),
                    FlatButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FireBaseShowData())),
                        label: Text('Show Firebase Data'), icon: Icon(Icons.cloud_download)),
                    RaisedButton(
                        child: Text('JsonApi Oracle'),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JsonApi()))),

                  ],
                ),
              ),
            ]);
          },
        ));
  }

  _launchURL(String s) async {
    var url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  gotoweatherornot(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Please sign in to view Weather')));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Weatherscreen()));
    }
  }
}
