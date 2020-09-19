import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //this is the App Bar
          title: Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.red[600]),
      body: Builder( builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RaisedButton(
                //below we have added option for signing in with google. This option is very easy to use and most of the code is boiler plate
                //we just have to write the below two lines and then the lines in 'singninwithgoogle' method
                  child: Text('Sign in with Google'),
                  onPressed: () => signinWithGoogle(context)),
              SizedBox(height: 20,),
              Text('OR'),
              Container(
                width: 300,
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  obscureText: true , //for hiding the typing
                  controller: passwordcontroller,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                  child: Text('Sign In'),
                  //below we call the 'createuserwithemail' method (function) on press, we pass the 2 text field values and the context
                  onPressed: () => signIn(context,
                      emailcontroller.text,
                      passwordcontroller.text))
            ],
          ),
        );
      })
      ,
    );
  }

  //below method is called when the "sign in with google" button is pressed. I think all the code is standard copy paste.
  signinWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);
    FirebaseAuth.instance.signInWithCredential(credential).whenComplete(()
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

  }

  signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).whenComplete(()
      {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Sign in Successful'),
          /*
          snackbar has a action property in which we can specify any action a user can perform when the message is displayed.
          Below we have set that the snackbar message should show for 5 seconds and have made the "Go to home page" part clickable
          and we have pop'ed this page to show the main landing page.
           */
          duration: Duration(seconds: 5),
          action: SnackBarAction(onPressed: () { return Navigator.pop(context); }, label: "Go to Home page",),));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }
}
