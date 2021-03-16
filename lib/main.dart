import 'package:dark_chat/screens/chtRoomScreen.dart';
import 'package:dark_chat/screens/newChat.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dark_chat/screens/login_screen.dart';
import 'package:dark_chat/screens/registration_screen.dart';
import 'package:dark_chat/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DarkChat());
}

class DarkChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthService().getCurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return ChatRoom();
          }else{
            return LoginScreen();
          }

        },
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        NewChat.id:(context)=>NewChat(),
        ChatRoom.id:(context)=>ChatRoom(),
      },
    );
  }
}
// class TestUi extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: PChatRoom(),
//       debugShowCheckedModeBanner: false,
//     );
//
//   }
// }