import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_chat/constants.dart';
import 'package:dark_chat/screens/chat_screen.dart';
import 'package:dark_chat/services/fireBackend.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewChat extends StatefulWidget {
  static String id = "NewChat";
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  bool isLoading = false;

  FToast fToast;
  TextEditingController newChatController = TextEditingController();

  FireBackendServices fireBackendServices = FireBackendServices();

  QuerySnapshot searchResultSnapshot;

  bool haveUserSearched = false;

  initiateSearch() async {
    if (newChatController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      await fireBackendServices
          .searchByName(newChatController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  checkIfMessagingThemselves(String txt) {
    if (txt == Constants.myName) {
      return true;
    } else
      return false;
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.size,
            itemBuilder: (context, index) {
              print(searchResultSnapshot.docs[index]["userName"]);
              print(searchResultSnapshot.docs[index]["email"]);
              return userTile(
                searchResultSnapshot.docs[index]["userName"],
                searchResultSnapshot.docs[index]["email"],
              );
            })
        : Container();
  }

  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    try{fireBackendServices.createChatRoom(chatRoom, chatRoomId);}catch(e){print("send message error : $e");}
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  chatRoomId: chatRoomId,chatUserName: userName,
                )));
  }

  Widget userTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Constants.kPrimaryColorMoreLight, fontSize: 16),
              ),
              Text(
                userEmail,
                style: TextStyle(color:Constants.kPrimaryColorMoreLight, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Constants.kPrimaryColorLight.withOpacity(1),),
      backgroundColor: Constants.kPrimaryColorDark,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                    decoration: BoxDecoration(
                  color: Colors.white54,

                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),

                    child: Row(
                      children: [
                        SizedBox(width: 16,),
                        Expanded(
                          child: TextField(
                            controller: newChatController,
                            onSubmitted: (val){
                              checkIfMessagingThemselves(newChatController.text)
                                  ? print('stop messaging yourself')
                                  : initiateSearch();
                            },
                            decoration: InputDecoration(
                                hintText: "Search Username ...",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            checkIfMessagingThemselves(newChatController.text)
                                ? _showToast("You Can't Message yourself!")
                                : initiateSearch();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Icon(Icons.search)),
                          ),
                        )
                      ],
                    ),
                  ),
                  userList()
                ],
              ),
            ),
    );
  }
}
