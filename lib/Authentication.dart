import 'package:firebase_auth/firebase_auth.dart'; //have to import this for firebase authentication, on main.dart we had imported 'firebase_core.dart''
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//This screen is for create a account using email and password

class Authentication extends StatefulWidget {
  //first create a stateful widget
  @override
  _AuthenticationState createState() =>
      _AuthenticationState(); // this line was created automatically as part of creating a stateful widget
}

class _AuthenticationState extends State<Authentication> {
  //below 3 lines are text field controllers
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser.toString());
    return Scaffold(
        appBar: AppBar(
            //this is the App Bar
            title: Text("Firebase Authentication"),
            centerTitle: true,
            backgroundColor: Colors.red[600]),
        //body contains 3 text fields and a 'Create account' button
        body:
            //builder is used to reproduce the context so that it can be passed to Widgets requreing contexts like snackbar, bottomsheet etc
            Builder(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(20),
              width: 600,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextField(
                    obscureText: true, //for hiding the typing
                    controller: passwordcontroller,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  TextField(
                      obscureText: true, //for hiding the typing
                      controller: confirmpasswordcontroller,
                      decoration:
                          InputDecoration(hintText: 'Confirm Password')),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        RaisedButton(
                            child: Text('Create Account'),
                            //below we call the 'createuserwithemail' method (function) on press, we pass the 2 text field values and the context
                            onPressed: () => createuserwithemail(
                                context,
                                emailcontroller.text,
                                passwordcontroller.text,
                                confirmpasswordcontroller.text)),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  //this is the method called when "create account" button is pressed, it accepts the email, password and confirmpassword from the text boxes
  // We always have to also type the 'BuildContext context' by default else it will not work. Read about context on google.
  createuserwithemail(BuildContext context, String email, String password,
      String confirmpassword) async {
    if (password != confirmpassword) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Password and Confirm Password do not match')));
      return;
    }

    try {
      // most of the code in this method is standard for firebase authentication, in the below line 'email: email', then second email is the input parameter, same goes for the password
      //below we are using 'Navigator.pop(context)' to remove this screen from top after Authentication is successful. As Flutter screens are shown one above the other, we used
      //pop to destroy this screen. We could have alternatively used "Navigator.push' (our normal way) too to redirect to the main screen.
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() 
      {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Your account has been created and you are now signed in'),
          /*
          snackbar has a action property in which we can specify any action a user can perform when the message is displayed.
          Below we have set that the snackbar message should show for 5 seconds and have made the "Go to home page" part clickable
          and we have pop'ed this page to show the main landing page.
           */
          duration: Duration(seconds: 5),
          action: SnackBarAction(onPressed: () { return Navigator.pop(context); }, label: "Go to Home page",),));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(
            'The account already exists for that email. Please use a different username');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
