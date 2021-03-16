import 'package:dark_chat/screens/chtRoomScreen.dart';
import 'package:dark_chat/screens/registration_screen.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:dark_chat/services/fireBackend.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dark_chat/widgets/signIn-UpUi.dart';
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
  FToast fToast;
  googleSignIn()async{
    setState(() {
      showProgressIndicator = true;
    });
    bool issigned =await AuthService().signInWithGoogle(context);
    if(issigned == false){
      print("Error in the login sytem");
      setState(() {
        showProgressIndicator = false;
      });
      _showToast("Google Sign In Error");}else{
    await AuthService().updateUsername();
    await authService.updateUserNameSharedPrefrences();
    Navigator.pushReplacementNamed(context, ChatRoom.id);}
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
  signIn()async{
    if(formkey.currentState.validate()){
      FocusScope.of(context).unfocus();
      setState(() {
        showProgressIndicator = true;
      });
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text).then((value) {if(value == null){
        print("Error in the login sytem either no account like that of no ");
        setState(() {
          setState(() {
            showProgressIndicator = false;
          });
        });
        _showToast("No Such User Exists");
      }});
      await authService.updateUserNameSharedPrefrences();
      Navigator.pushReplacementNamed(context, ChatRoom.id);
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kBGColorDark,
        body: ModalProgressHUD(
          inAsyncCall: showProgressIndicator,
          child: SingleChildScrollView(
            child: Padding(
              padding: Responsive.isDesktop(context)? EdgeInsets.all(0): EdgeInsets.symmetric(horizontal: Responsive.sWidth(context)*.3),
              child: Stack(
                children: [
                  Image.asset('images/moonlightFullBlack.png',width: 400,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 110,),
                      Text(
                        "Sign In",
                        style: GoogleFonts.pacifico(fontStyle: FontStyle.normal,fontSize: 30),
                      ),
                      SizedBox(height: Responsive.sHeight(context) * 0.01),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            RoundedInputField(
                              hintText: "Your Email",
                              onSubmitted: signIn,
                              onChanged: (value) {},
                              controller: emailController,
                              fuc: (val){
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                                null : "Enter a correct email";
                              },
                            ),
                            RoundedPasswordField(
                              onChanged: (value) {},
                              onSubmitted: signIn,
                              controller: passwordController,
                              fuc: (val){
                                return val.length < 6 ? "Password must be more than 6 characters" : null;
                              },
                            ),
                          ],
                        ),
                      ),

                      RoundedButton(
                        text: "SIGIN",
                        press: signIn,
                      ),
                      SizedBox(height: Responsive.sHeight(context) * 0.01),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {

                                return RegistrationScreen();
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
                            iconSrc: "images/google_logo.png",
                            press: googleSignIn,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
