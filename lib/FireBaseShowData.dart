import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trying_layout/data/user/UserEntity.dart';

/*
This page displays the data that we have in our "TryingAppUsers" collection (table)
*/

class FireBaseShowData extends StatefulWidget {
  @override
  _FireBaseShowDataState createState() => _FireBaseShowDataState();
}

class _FireBaseShowDataState extends State<FireBaseShowData> {
  //we created a list variable to store the users data that would be returned
  // the 'UserEntity' in the line below is the class we had made earlier using Json2dart plug in.
  List<UserEntity> var_users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //this is the App Bar, this is standard part of the SCAFFOLD and comes by itself
          title: Text("Showing our data from Firebase"),
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
          //below button is the event handler, we press this to get the data, it call the
          //method we created "fetchFireBaseData" and passes the name of the collection from where to get data
          FlatButton(
              child: Text('Fetch Data'),
              onPressed: () => fetchFireBaseData("TryingAppUsers")),
          if (var_users.isEmpty)
            Container()
          else //this else part is reached only if the List var_users has data.
            //"Listview" is just a widget which we have used to show data in rows
            ListView.builder(
              shrinkWrap: true,
              // as list 'var_users' now has data (which was put by 'fetchFireBaseData' method, we set the length of 'Listview' to it
              itemCount: var_users.length,
              //itembuilder is a property of 'ListView.builder', it needs a context and index as input values, so below
              // we are passing the value ('name' column of the var_users list to it. ListView will loop automatically till the
              //length we have defined.
              itemBuilder: (BuildContext context, int index) => ListTile(title: Text(var_users[index].name,),
            )
            )],
      ),
    );
  }

  //this is the method we created to fetch from firebase database
  fetchFireBaseData(String s) async {
    var_users = [];
    await FirebaseFirestore.instance
    //below in comment is how we add a 'where' clause to our query (in case if it is required)
        //.collection(s).where("age", isGreaterThan: 25)
        .collection(s) // 's' is the value that gets passed in (the collection name)
        .get()
        .then((value) => value.docs.forEach((element) {
          //firebase stores data in the form of Json, so to parse that data and make it of type userentity
      // we used 'UserEntity.fromJsonMap(element.data()) and added to the var_users list which is of type 'userentity'
              var_users.add(UserEntity.fromJsonMap(element));
            }));
    print(var_users);
    setState(() {

    });
  }


}
