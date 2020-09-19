import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trying_layout/data/weather/weatherentity.dart';

class Weatherscreen extends StatefulWidget {
  @override
  _WeatherscreenState createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  Weatherentity weather;
  TextEditingController zipmonitor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //this is the App Bar, this is standard part of the SCAFFOLD and comes by itself
            title: Text("Rashi/'s Weather for Today"),
            //added this to the app bar for signout. Used flatbutton as it has transperant background and will blend in to the app bar
            actions: [
              if(FirebaseAuth.instance.currentUser != null)
                FlatButton(child: Text('Sign Out'), onPressed: () => FirebaseAuth.instance.signOut().then((value) {setState(() {});}))
              else
                Container() // put empty container whenever you have nothing else to put in a the 'else' part of a IF.
            ],
            centerTitle: true,
            backgroundColor: Colors.red[600]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RaisedButton(
                child: Text('Show Weather'),
                onPressed: () => getweather()),
              if (weather == null)
                Container()
              else
                Text(weather.main.temp.toString()),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      controller: zipmonitor,
                    ),
                  ),
                  RaisedButton(
                      child: Text('Weather by City'),
                      onPressed: () => getweatherbyzip(zipmonitor.text)),
                ],
              ),

            ],
          ),
        ));
  }

  getweather() async {
    var response = await Dio().get(
        'http://api.openweathermap.org/data/2.5/weather?q=cumming&appid=ac03d19c06e01f780db638abb3ec02d5');
    // print(response.data['main']['temp']); If we would not have used the Json2dart plugin and auto generated the classes,
    // then we would have to parse the jason string this way to get to individual values
    weather = Weatherentity.fromJsonMap(response.data);
    setState(() {});
  }

  /*
  getweather() async {
    var response = await Dio().get(
        'http://api.openweathermap.org/data/2.5/weather?q=cumming&appid=ac03d19c06e01f780db638abb3ec02d5');
    weather = Weatherentity.fromJsonMap(response.data);
    setState(() {});
   */

  getweatherbyzip(String zip) async {
    var response = await Dio().get(
        'http://api.openweathermap.org/data/2.5/weather?q=$zip&appid=ac03d19c06e01f780db638abb3ec02d5');
    weather = Weatherentity.fromJsonMap(response.data);
    setState(() {});
  }
}
