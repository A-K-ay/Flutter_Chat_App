import 'package:dark_chat/screens/login_screen.dart';
import 'package:dark_chat/screens/registration_screen.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/curvedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'newChat.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  googleSignIn()async{
    await AuthService().signInWithGoogle(context);
    await AuthService().updateUsername();
    Navigator.pushReplacementNamed(context, NewChat.id);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FirebaseAuth _auht = FirebaseAuth.instance;
    _auht.currentUser.email != null? print("session saved"):print("not Saved");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100,
                  ),
                ),
                Text(
                  "Dark Chat",
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                Text(
                  "Be",
                  style: TextStyle(fontSize: 22.0),
                ),
                SizedBox(width: 20.0, height: 100.0),
                SizedBox(
                  height: 60,
                  child: RotateAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      text: ["Anonymous", "Untraceable", "Free"],
                      textStyle: TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
                      textAlign: TextAlign.start),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            CurvedButton(fuc: (){Navigator.pushNamed(context, LoginScreen.id);},txt: 'Login',),
            CurvedButton(fuc: (){Navigator.pushNamed(context, RegistrationScreen.id);},txt: 'Register',),
            CurvedButton(fuc:(){
             googleSignIn();
              },txt:"Sign In With Google"),
          ],
        ),
      ),
    );
  }
}


