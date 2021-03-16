// import 'package:dark_chat/services/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import '/constants.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/cupertino.dart';
// import '/components/already_have_an_account_acheck.dart';
// import '/components/rounded_button.dart';
// import '/components/rounded_input_field.dart';
// import '/components/rounded_password_field.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'newloginui.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   final formkey =GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset('images/img2.png',height: 270,width: 270,),
//               Text(
//                 "Sign Up",
//                 style: GoogleFonts.pacifico(fontStyle: FontStyle.normal,fontSize: 30),
//               ),
//               SizedBox(height: Responsive.sHeight(context) * 0.01),
//               Form(
//                 key: formkey,
//                 child: Column(
//                   children: [
//                     RoundedInputField(
//                       hintText: "Enter a Username",
//                       onChanged: (value) {},
//                       controller:usernameController,
//                       fuc: (val){
//                         return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
//                       },
//                     ),
//                     RoundedInputField(
//                       hintText: "Your Email",
//                       onChanged: (value) {},
//                       controller: emailController,
//                       fuc: (val){
//                         return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
//                         null : "Enter a correct email";
//                       },
//                     ),
//                     RoundedPasswordField(
//                       onChanged: (value) {},
//                       fuc: (val){
//                         return val.length < 6 ? "Password must be more than 6 characters" : null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               RoundedButton(
//                 text: "SIGNUP",
//                 press: signup,
//               ),
//               SizedBox(height: Responsive.sHeight(context) * 0.01),
//               AlreadyHaveAnAccountCheck(
//                 login: false,
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//
//                         return LoginScreen();
//                       },
//                     ),
//                   );
//                 },
//               ),
//               OrDivider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//
//                   SocalIcon(
//                     iconSrc: "images/google-plus.svg",
//                     press: () {},
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }
//
//
//
//
//
// class SocalIcon extends StatelessWidget {
//   final String iconSrc;
//   final Function press;
//   const SocalIcon({
//     Key key,
//     this.iconSrc,
//     this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: kPrimaryLightColor,
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(
//           iconSrc,
//           height: 20,
//           width: 20,
//         ),
//       ),
//     );
//   }
// }
//
// class OrDivider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
//       width: size.width * 0.8,
//       child: Row(
//         children: <Widget>[
//           buildDivider(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               "OR",
//               style: TextStyle(
//                 color: kPrimaryColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           buildDivider(),
//         ],
//       ),
//     );
//   }
//
//   Expanded buildDivider() {
//     return Expanded(
//       child: Divider(
//         color: Color(0xFFD9D9D9),
//         height: 1.5,
//       ),
//     );
//   }
// }