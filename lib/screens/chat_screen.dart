
import '../constants.dart';
import '../services/fireBackend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = "Chat_Screen";
  final String chatRoomId;
  final String chatUserName;

  ChatScreen({this.chatRoomId,this.chatUserName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = TextEditingController();

  Widget chatMessages(){
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot){

        return snapshot.hasData ?  ListView.builder(
          reverse: true,
            itemCount: snapshot.data.size,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.docs[index]["message"],
                sendByMe: Constants.myName == snapshot.data.docs[index]["sendBy"],
              );
            }) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime
            .now(),
      };

      FireBackendServices().addMessages(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    try{chats = FireBackendServices().getMessages(widget.chatRoomId);
    chats.isEmpty != null ? print("stream is empty"):print("this stream works") ;

    }
    catch(e){print('$e');}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColorDark,
      appBar: AppBar(backgroundColor: Constants.kPrimaryColorLight.withOpacity(1),title:Text( widget.chatUserName),),
      body: Container(
        child: Stack(
          children: [
            Container(margin:EdgeInsets.only(bottom: 64,),child: chatMessages()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
              alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Constants.kPrimaryColorLight,
                          Constants.kPrimaryColorLight.withOpacity(.5),
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16,),
                    Expanded(

                        child: TextField(
                          controller: messageEditingController,
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Constants.kPrimaryColorMoreLight,
                                fontSize: 16,
                              ),
                              border: InputBorder.none
                          ),
                        )),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(8),
                          child: Center(child: Image.asset('images/sendgold.png'))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}