

import 'package:dark_chat/screens/chat_screen.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:dark_chat/services/fireBackend.dart';
import 'package:dark_chat/widgets/curvedButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'newChat.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool showProgressIndicator = false;
  final formkey =GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final FireBackendServices fireBackendServices = FireBackendServices();

  signUp()async{
    if(formkey.currentState.validate()){
      showProgressIndicator = true;
     await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text).then((value) => print(value));
      Map<String,String> userMap = {
        "userName": usernameController.text,
        "email": emailController.text
      };
     await fireBackendServices.uploadUserInfo(userMap);
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
                      controller: usernameController,
                      textAlign: TextAlign.center,
                      validator: (val){
                        return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                      },
                      decoration: kInputDecoration.copyWith(hintText: "Enter a username"),
                    ),
                    SizedBox(
                    height: 8.0,
                  ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter a correct email";
                      },
                      decoration:  kInputDecoration.copyWith(hintText: "Enter your email"),
                    ),

                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      validator:  (val){
                        return val.length < 6 ? "Password must be more than 6 characters" : null;
                      },
                      decoration: kInputDecoration,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),

              CurvedButton(fuc: signUp, txt: "Register")
            ],
          ),
        ),
      ),
    );
  }
}
