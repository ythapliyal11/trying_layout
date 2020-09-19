import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trying_layout/data/user/UserEntity.dart';

class FireBase extends StatefulWidget {
  @override
  _FireBaseState createState() => _FireBaseState();
}
/*
This page displays a form consisting of text fields, radio buttons, check box and a drop down menu. When this form
is filled, it saves to our firebase database. This is for firestore create operation
 */
class _FireBaseState extends State<FireBase> {
  //below 2 lines are the normal text controllers
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  // below I have made 3 variables to store the values of dropdown, radio and checkbox respectively. for now
  //I have given them default values.
  String var_dropdownvalue = "Select Location";
  String var_radiovalue = "Not Selected";
  bool var_smoker = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          //this is the App Bar, this is standard part of the SCAFFOLD and comes by itself
          title: Text("FireBase Database"),
          //added this to the app bar for signout. Used flatbutton as it has transperant background and will blend in to the app bar
          actions: [
            //this is the 'sign out' link that we have given on all pages
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
      body: Container(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //below are the text fields
            children: [
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: agecontroller,
                decoration: InputDecoration(hintText: 'Age'),
              ),
              Row(
                children: [
                  //below is the text (Male) that we need to display against the radio button
                  Text('Male'),
                  Radio(
                      value: 'Male',  //here we set the value of the radio button
                      //group value makes a group of radio buttons. We need to give the same value to this property
                      //what we did is assign the value of "var_radiovalue" as group value. So initially the groupvalue for all
                      //radio buttons is 'Not Selected', when a radio button is clicked, all radio buttons 'groupValue' will
                      //be changed to the value of whatever button is selected.
                      groupValue: var_radiovalue,
                      //onChanged is called when we select a radio button. Flutter passes 'Male' which is the value of this radio
                      //button to this property in the form of "newradiovalue" (we can name this anything)
                      // to this property and its method written below it.
                      onChanged: (newradiovalue) {
                        setState(() {
                          var_radiovalue = newradiovalue;  // in this line, the 'var_radiovalue' variable is assigned the value of this radio button (Male)
                        });
                      }),
                  Text('Female'),
                  // all the comments given for the above radio button is applicable to this one too.
                  Radio(
                      value: 'F',
                      groupValue: var_radiovalue,
                      onChanged: (newradiovalue) {
                        setState(() {
                          var_radiovalue = newradiovalue;
                        });
                      })
                ],
              ),
              Row(
                children: [
                  Text('Smoker'),
                  //checkboxes work similarly to radio buttons. They don't have a group value for obvious reasons
                  Checkbox(
                      value: var_smoker,
                      onChanged: (value) {
                        setState(() {
                          var_smoker = value;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  Text('Select a location'),
                  SizedBox(width: 15),
                  //dropdown looks complicate at first.
                  DropdownButton(
                    //Below we have set the initial value to "Select Location" which we put in var_dropdown when we declared it at the top of this page
                    value: var_dropdownvalue,
                      items: [
                        //below are the items which will be displayed inside the dropdown
                        DropdownMenuItem(child: Text('Select Location'), value: 'Select Location'),
                        DropdownMenuItem(child: Text('Mumbai'), value: 'Mumbai'),
                        DropdownMenuItem(child: Text('Atlanta'), value: 'Atlanta'),
                        DropdownMenuItem(child: Text('Aligarh'), value: 'Aligarh'),
                        DropdownMenuItem(child: Text('New York'), value: 'New York'),
                      ],
                      onChanged: (value) { // This part looks common with radio buttons and check boxes
                        setState(() {
                          var_dropdownvalue = value;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
      //below we are using a "floatingActionButton" as a submit button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
          //we had earlier added 'FirebaseFirestore' as a dependency in pubspec.yml file. Below we are
          //creating a instance of that plugin and then telling it our collection name (TryingAppUsers).
          //if this plugin finds a collection with that name already in our profile, then it adds a document (record) to
          //that collection, else it creates a collection by that name and then adds the document
          onPressed: () => FirebaseFirestore.instance.collection('TryingAppUsers')
          // the '.doc' property is the unique identification string that each document (record) has. if we keep it null
          //then it automatically assigns some string to it.
          //the 'UserEntity' class below is a method we had created when we installed 'FirebaseFirestore' and used the Json2dart method to
          //convert the json components required by FirebaseStore into classes. The steps for these are mentioned in our word document.
              .doc().set(UserEntity(namecontroller.text, int.parse(agecontroller.text), var_radiovalue, var_dropdownvalue, var_smoker).toJson()).then((value) {
                setState(() {
                  namecontroller.text = '';
                  agecontroller.text = '';
                  var_dropdownvalue = "Select Location";
                  var_radiovalue = "Not Selected";
                  var_smoker = false;
                });
          })
      ),
    );
  }
}
