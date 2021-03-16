// import 'package:dark_chat/screens/newsignupui.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import '/components/already_have_an_account_acheck.dart';
// import '/components/rounded_button.dart';
// import '/components/rounded_input_field.dart';
// import '/components/rounded_password_field.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }
//
//
//
// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: size.height * 0.04),
//           Image.asset('images/img1.png',height: 300,width: 300,),
//           Text(
//             "Login",
//             style: GoogleFonts.pacifico(fontStyle: FontStyle.normal,fontSize: 40),
//           ),
//
//           SizedBox(height: size.height * 0.03),
//           RoundedInputField(
//             hintText: "Your Email",
//             onChanged: (value) {},
//           ),
//           RoundedPasswordField(
//             onChanged: (value) {},
//           ),
//           RoundedButton(
//             text: "LOGIN",
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()),
//               );
//             },
//           ),
//           SizedBox(height: size.height * 0.03),
//           AlreadyHaveAnAccountCheck(
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return SignUpScreen();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
