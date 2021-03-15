import 'package:dark_chat/constants.dart';
import 'package:dark_chat/screens/chtRoomScreen.dart';
import 'package:dark_chat/screens/newChat.dart';
import 'package:dark_chat/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dark_chat/screens/welcome_screen.dart';
import 'package:dark_chat/screens/login_screen.dart';
import 'package:dark_chat/screens/registration_screen.dart';
import 'package:dark_chat/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: WelcomeScreen.id,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthService().getCurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return ChatRoom();
          }else{
            return WelcomeScreen();
          }

        },
      ),
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        NewChat.id:(context)=>NewChat(),
        ChatRoom.id:(context)=>ChatRoom(),
      },
    );
  }
}
