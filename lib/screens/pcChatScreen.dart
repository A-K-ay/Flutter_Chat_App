//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dark_chat/screens/login_screen.dart';
// import 'package:dark_chat/services/responsive.dart';
// import '../constants.dart';
// import '../services/authentication.dart';
// import '../services/fireBackend.dart';
// import '../screens/chat_screen.dart';
// import '../screens/newChat.dart';
// import 'package:flutter/material.dart';
// class PChatRoom extends StatefulWidget {
//   static String id = "chatRoom";
//   @override
//   _PChatRoomState createState() => _PChatRoomState();
// }
//
// class _PChatRoomState extends State<PChatRoom> {
//   Stream chatRooms;
//
//   Widget chatRoomsList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: chatRooms,
//       builder: (context, snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//             itemCount: snapshot.data.size,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               print('...'+snapshot.data.docs[index]['chatRoomId']);
//               return ChatRoomsTile(
//                 userName: snapshot.data.docs[index]['chatRoomId']
//                     .toString()
//                     .replaceAll("_", "")
//                     .replaceAll(Constants.myName, ""),
//                 chatRoomId: snapshot.data.docs[index]["chatRoomId"],
//               );
//             })
//             : Container();
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     getUserInfogetChats();
//     super.initState();
//   }
//
//   getUserInfogetChats() async {
//     await AuthService().updateUsername();
//     print('first run');
//     setState(() {
//       chatRooms = FireBackendServices().getChatRooms(Constants.myName);
//       print(
//           "we got the data + ${chatRooms.toString()} username is name  ${Constants.myName}");
//     });
//     print(chatRooms.isEmpty);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Constants.kPrimaryColorDark,
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: false,
//         backgroundColor: Constants.kPrimaryColorLight.withOpacity(1),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               AuthService().signOut();
//               Navigator.pushReplacementNamed(context,
//                   LoginScreen.id);
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Icon(Icons.exit_to_app,color: Constants.kPrimaryColorSkin,)),
//           )
//         ],
//       ),
//       body: Row(
//         children: [
//           Container(
//             width: Responsive.sWidth(context)*5,
//             height: Responsive.sHeight(context),
//             child: chatRoomsList(),
//           ),
//           Container(
//             width: Responsive.sWidth(context)*5,
//             height: Responsive.sHeight(context),
//             child: chatRoomsList(),
//           ),
//
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Constants.kPrimaryColorGreen,
//         child: Icon(Icons.message_outlined),
//         onPressed: () {
//           Navigator.pushNamed(
//               context, NewChat.id);
//         },
//       ),
//     );
//   }
// }
//
// class ChatRoomsTile extends StatelessWidget {
//   final String userName;
//   final String chatRoomId;
//
//   ChatRoomsTile({this.userName,@required this.chatRoomId});
//
//   @override
//   Widget build(BuildContext context) {
//     return userName.isEmpty||chatRoomId.isEmpty?Container():GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(
//             builder: (context) => ChatScreen(
//               chatRoomId: chatRoomId,chatUserName: userName,
//             )
//         ));
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 16.0),
//         child: Container(
//           decoration: BoxDecoration(
//               color:  Colors.black26,
//               borderRadius: BorderRadius.circular(10)),
//           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Row(
//             children: [
//               Container(
//                 height: 30,
//                 width: 30,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Center(
//                   child: Text(userName.substring(0, 1).toUpperCase(),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontFamily: 'OverpassRegular',
//                           fontWeight: FontWeight.w300)),
//                 ),
//               ),
//               SizedBox(
//                 width: 12,
//               ),
//               Text(userName,
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                       color: Constants.kPrimaryColorMoreLight,
//                       fontSize: 16,
//                       fontFamily: 'OverpassRegular',
//                       fontWeight: FontWeight.w300))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }