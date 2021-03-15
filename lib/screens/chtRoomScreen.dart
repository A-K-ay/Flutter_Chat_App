
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_chat/screens/welcome_screen.dart';
import '../constants.dart';
import '../services/authentication.dart';
import '../services/fireBackend.dart';
import '../screens/chat_screen.dart';
import '../screens/newChat.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatefulWidget {
  static String id = "chatRoom";
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.size,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print('yooooooooooooo'+snapshot.data.docs[index]['chatRoomId']);
              return ChatRoomsTile(
                userName: snapshot.data.docs[index]['chatRoomId']
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants.myName, ""),
                chatRoomId: snapshot.data.docs[index]["chatRoomId"],
              );
            })
            : Container(color: Colors.blue,width: 200,height: 300,child: Text('No Data Untill now',),);
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    await AuthService().updateUsername();
    print('first run');
    setState(() {
      chatRooms = FireBackendServices().getChatRooms(Constants.myName);
      print(
          "we got the data + ${chatRooms.toString()} username is name  ${Constants.myName}");
    });
    print(chatRooms.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Icon(Icons.ac_unit),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushReplacementNamed(context,
                  WelcomeScreen.id);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(
              context, NewChat.id);
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return userName.isEmpty||chatRoomId.isEmpty?Container(color:Colors.amber,height: 200,width: 400,child: Text('please restart teh app'),):GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatRoomId: chatRoomId,
            )
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(userName.substring(0, 1).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}