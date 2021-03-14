import 'package:dark_chat/constants.dart';
import 'package:dark_chat/screens/chat_screen.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:dark_chat/services/fireBackend.dart';
import 'package:dark_chat/widgets/curvedButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'newChat.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgressIndicator = false;
  final AuthService authService = AuthService();
  final FireBackendServices fireBackendServices = FireBackendServices();
  final formkey =GlobalKey<FormState>();

  signIn()async{
    if(formkey.currentState.validate()){
      showProgressIndicator = true;
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text).then((value) => print(value));
      Navigator.pushReplacementNamed(context, NewChat.id);
      showProgressIndicator = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgressIndicator,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter a correct email";
                      },
                      onChanged: (value) {

                      },
                      decoration:  kInputDecoration.copyWith(hintText: "Enter your email"),
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator:  (val){
                        return val.length < 6 ? "Password must be more than 6 characters" : null;
                      },
                      onChanged: (value) {
                      },
                      decoration:  kInputDecoration,
                      controller: passwordController,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 24.0,
              ),
              CurvedButton(fuc: signIn, txt: "Login")
            ],
          ),
        ),
      ),
    );
  }
}
