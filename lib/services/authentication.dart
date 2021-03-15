import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_chat/constants.dart';
import 'package:dark_chat/services/sharedPreferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'fireBackend.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FireUser _userFromFirebaseUser(User user) {
    return user != null ? FireUser(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      SharedPrefrenceServise().saveUserEmail(user.email);
      SharedPrefrenceServise().saveUserId(user.uid);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }else {print(e);
      return null;}
    }
  }
  getCurrentUser()async{
    updateUsername();
    return await _auth.currentUser;

  }
  updateUsername()async{
    User user  = _auth.currentUser;
    Constants.myName = await SharedPrefrenceServise().getUserName();
    print("username updated to: ${Constants.myName} by updateUsername");
  }
  updateUserNameSharedPrefrences()
  async{
    User user  = _auth.currentUser;
    String usrname = await FireBackendServices().getUserNameByEmail(user.email);
    Constants.myName = usrname;
    SharedPrefrenceServise().saveUserName(usrname) ;
    print("username updated to: ${Constants.myName} updateUserNameSharedPrefrences");
  }

  signInWithGoogle(BuildContext context)async{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );
    UserCredential result = await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user;
    if(result != null){
      SharedPrefrenceServise().saveUserEmail(userDetails.email);
      SharedPrefrenceServise().saveUserId(userDetails.uid);
      Map<String,String> userMap = {
        "userName": userDetails.displayName,
        "email": userDetails.email
      };
      await FireBackendServices().uploadUserInfo(userMap);
      await updateUserNameSharedPrefrences();

    }

  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      SharedPrefrenceServise().saveUserEmail(user.email);
      SharedPrefrenceServise().saveUserId(user.uid);

      return _userFromFirebaseUser(user);
    }catch(e) {print("signuperror form authservice: $e");}
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future signOut()async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      _auth.signOut();


    }catch(e){
      print(e);
    }
  }



}