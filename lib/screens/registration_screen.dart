

import 'package:dark_chat/screens/chtRoomScreen.dart';
import 'package:dark_chat/screens/newChat.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:dark_chat/services/fireBackend.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dark_chat/services/responsive.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter/widgets.dart';

import 'login_screen.dart';
import 'package:dark_chat/widgets/signIn-UpUi.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  FToast fToast;
  bool showProgressIndicator = false;
  final formkey =GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final FireBackendServices fireBackendServices = FireBackendServices();

  googleSignIn()async{
    await AuthService().signInWithGoogle(context);
    await AuthService().updateUsername();
    Navigator.pushReplacementNamed(context, NewChat.id);
  }
  _showToast(String txt) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Constants.kPrimaryColorSkin,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outlined,color: Colors.redAccent,),
          SizedBox(
            width: 12.0,
          ),
          Text(txt),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );


  }
  signUp()async{
    if(formkey.currentState.validate()){
      FocusScope.of(context).unfocus();
      setState(() {
        showProgressIndicator = true;
      });
     await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text).then((value) {if(value == null){
       print("there was an error");
       setState(() {
         showProgressIndicator = false;
       });
       _showToast("User Exists already");
     }});
      Map<String,String> userMap = {
        "userName": usernameController.text,
        "email": emailController.text
      };
     await fireBackendServices.uploadUserInfo(userMap);
     await authService.updateUserNameSharedPrefrences();
      Navigator.pushReplacementNamed(context, ChatRoom.id);
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgressIndicator,
        child: SingleChildScrollView(
          child: Padding(
            padding:Responsive.isDesktop(context)? EdgeInsets.all(0): EdgeInsets.symmetric(horizontal: Responsive.sWidth(context)*.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/img2.png',height: 270,width: 270,),
                Text(
                  "Sign Up",
                  style: GoogleFonts.pacifico(fontStyle: FontStyle.normal,fontSize: 30),
                ),
                SizedBox(height: Responsive.sHeight(context) * 0.01),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      RoundedInputField(
                        hintText: "Enter a Username",
                        onChanged: (value) {},
                        onSubmitted: signUp,
                        controller:usernameController,
                        fuc: (val){
                          return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Your Email",
                        onChanged: (value) {},
                        onSubmitted: signUp,
                        controller: emailController,
                        fuc: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                          null : "Enter a correct email";
                        },
                      ),
                      RoundedPasswordField(
                        onChanged: (value) {},
                        onSubmitted: signUp,
                        controller: passwordController,
                        fuc: (val){
                          return val.length < 6 ? "Password must be more than 6 characters" : null;
                        },
                      ),
                    ],
                  ),
                ),

                RoundedButton(
                  text: "SIGNUP",
                  press: signUp,
                ),
                SizedBox(height: Responsive.sHeight(context) * 0.01),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {

                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    SocalIcon(
                      iconSrc: "images/google-plus.svg",
                      press: googleSignIn,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

