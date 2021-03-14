import 'package:cloud_firestore/cloud_firestore.dart';

class FireBackendServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  getUserByUsername(String username) {
    firebaseFirestore
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
  IsUserSignedIn(){

  }
  getUserNameByEmail(String email){
    firebaseFirestore.collection("users").where("email",isEqualTo: email).get();
  }

  uploadUserInfo(userMap) {
    firebaseFirestore.collection('users').add(userMap).catchError((e) {
      print(e);
    });
  }
  searchByName(String searchField) {
    return firebaseFirestore
        .collection("users")
        .where('userName', isEqualTo: searchField)
    .get();
  }

  createChatRoom( chatRoomap,chatRoomId) {
    firebaseFirestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .set(chatRoomap)
        .catchError((e) {
      print(e);
    });
  }

  getMessages(String chatRoomId) {
   return firebaseFirestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("chats").snapshots();
  }
  addMessages(String chatRoomId, messageMap) {
    firebaseFirestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e);
    });
  }
}
