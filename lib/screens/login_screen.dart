import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_master/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_master/components/rounded_button.dart';
import 'package:flash_chat_master/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; //For adding Spinner

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool showSpinner = false; //For adding Spinner

  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        Navigator.pushNamed(context, ChatScreen.id);

        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD( //For adding Spinner
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible( //It reduces its size when it get less space
                child: Hero(
                  //Hero Animation
                  tag: 'logo', //Hero Animation tag
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 200.0,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                controller: emailController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                controller: passController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Login',
                onPress: () {
                  signIn(emailController.text, passController.text);
                  emailController.clear();
                  passController.clear();
                  setState(
                    () {
                      showSpinner = true;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
