import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JsonApi extends StatefulWidget {
  @override
  _JsonApi createState() => _JsonApi();
}
/*
This page sends a 'Post' form method call to my python flask 'Jsonapi' route.
I think if we would have used 'Get' then it would have been easier to test as we could have tested the api
by appending the variables to the URL.
Anyway we tested the api code using Postman app and it worked. So the python code is working
There are two situtions that it handles.
1) Only Pantherid is sent and it returns the pantherid and name when we press the "get name" button.
2) We update the name by changing the spelling that was sent back in the above call
   and press the "update name" button. The python code that I have hosted at ythapliyal.pythonanywhere.com should return the
   updated spelling of my name.

This does not work in the emulator if my python api is hosted locally. I had to host it externally at pythonanywhere.com
 */


class _JsonApi extends State<JsonApi> {
  //Below is standard code for creating textfield controllers
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pantheridcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          //this is the App Bar, that we can put in the SCAFFOLD
          title: Text("Json Api with Oracle"),
          //added this to the app bar for signout. Used flatbutton as it has transperant background and will blend in to the app bar
          actions: [
            if (FirebaseAuth.instance.currentUser != null)
              FlatButton(
                  child: Text('Sign Out'),
                  onPressed: () => FirebaseAuth.instance.signOut())
            else
              Container()
            // put empty container whenever you have nothing else to put in a the 'else' part of a IF.
          ],
          centerTitle: true,
          backgroundColor: Colors.red[600]),
      body: Column(
        children: [
          //Below are the name and pantherid text fields
          TextField(
            controller: namecontroller,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: pantheridcontroller,
            decoration: InputDecoration(hintText: 'Pantherid'),
          ),
          //below are 2 buttons. One for sending pantherid and getting back name and other for updating the name
          FlatButton(onPressed: () => fetchName(),
          child: Text('Get Name')),
          FlatButton( onPressed: () => updateName(), child: Text('Update Name')),
        ],
      ),
    );
  }

  //below method was created for "on pressed" even of the "get name".
  // This uses the Dio plugin we had gotten from pub.dev when we were working with weather page as that handles HTTP requests.
  // To indicate to the server that we are only seeking the name for now, the 'type' indicator was included, it is same like the hidden fields we use in HTML
  // so we can say that we have a hidden field named "type" in which we are passing value "searchform". Python is looking for this value
  // read the python code to check how this is handled.
  fetchName() async {
    final nameresponse = await Dio().post("https://ythapliyal.pythonanywhere.com/", data: FormData.fromMap({
      "type": "searchform",
      "panther_id": pantheridcontroller.text
    }));
    print(nameresponse.data);
    namecontroller.text = nameresponse.data["First_Name"];
    pantheridcontroller.text = nameresponse.data["pantherid"];
    setState(() {

    });
  }

  //Below method is called when we press the "update name" button.
  //these methods are asyncronous and after receiving the data we have to call 'setState' again to refresh
  //the screen with new data.
  updateName() async {
    final nameresponse = await Dio().post("https://ythapliyal.pythonanywhere.com/", data: FormData.fromMap({
      "type": "update",
      "panther_id": pantheridcontroller.text,
      "FirstName": namecontroller.text
    }));
    print(nameresponse.data);
    namecontroller.text = nameresponse.data["First_Name"];
    pantheridcontroller.text = nameresponse.data["pantherid"];
    setState(() {

    });
  }
}
