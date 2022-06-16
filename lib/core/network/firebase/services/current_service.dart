import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'auth_base.dart';

class CurrentService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  //

  @override
  Future<AppUser?> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return await _userFromFirebase(user);
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  //
  //

  Future<AppUser?> _userFromFirebase(User? user) async {
    if (user == null) {
      print("x");
      return null;
    } else {
      DocumentSnapshot<Map<String, dynamic>> userFromFirebase =
          await _firestore.collection("users").doc(user.uid).get();

      var a = AppUser(
        email: userFromFirebase["email"],
        password: userFromFirebase["password"],
        id: user.uid,
        userName: userFromFirebase["userName"],
        orderList: userFromFirebase["orderList"],
      );

      print(a.email);
      print(a.orderList);

      return a;
    }
  }

  //
  //

  @override
  Future<bool> logout() async {
    debugPrint("current user state: " "${_firebaseAuth.currentUser}");
    try {
      // final GoogleSignIn googleSigniIn = GoogleSignIn();
      // if (googleSigniIn.currentUser != null) {
      //   await googleSigniIn.signOut();
      // }

      if (_firebaseAuth.currentUser?.isAnonymous == true) {
        debugPrint(
            "anonim user state: ${_firebaseAuth.currentUser?.isAnonymous}");
        await _firebaseAuth.currentUser?.delete();
      } else {
        debugPrint(
            "anonim user state: ${_firebaseAuth.currentUser?.isAnonymous}");
      }
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("error in services at signOut: [$e]");
      return false;
    }
  }

  //
  //

  @override
  Future<AppUser?> signinAnonim() async {
    try {
      UserCredential authCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(authCredential.user);
    } catch (e) {
      debugPrint("Error in Services, at siginAnonim [$e]");
      return null;
    }
  }

  //
  //

  // @override
  // Future<AppUser?> signInByGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     if (googleAuth.idToken != null && googleAuth.accessToken != null) {
  //       UserCredential credential = await _firebaseAuth.signInWithCredential(
  //         GoogleAuthProvider.credential(
  //           idToken: googleAuth.idToken,
  //           accessToken: googleAuth.accessToken,
  //         ),
  //       );
  //       final User? user = credential.user;
  //       return _userFromFirebase(user);
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  //
  //

  @override
  Future<AppUser?> createUserByEmailPassword(AppUser user) async {
    try {
      UserCredential authCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      user.id = authCredential.user!.uid;

      await _firestore
          .collection("users")
          .doc(authCredential.user!.uid)
          .set(user.toMap());

      var a = await _userFromFirebase(authCredential.user);

      return a;
    } catch (e) {
      debugPrint("Error in services, at createUserByEmailAndPassword: [$e]");
      return null;
    }
  }

  //
  //

  @override
  Future<AppUser?> loginByEmailPassword(String email, String password) async {
    try {
      // debugPrint(
      //     "DEBUG in FirebaseAuthService at signInByEmailPassword. \n  S${_firebaseAuth.currentUser?.emailVerified}");
      UserCredential authCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(authCredential.user);
    } catch (e) {
      debugPrint("Error in services, signInWithEmailAndPassword: [$e]");
      return null;
    }
  }

  // @override
  // bool? isVerified() {
  //   bool? isVerified = _firebaseAuth.currentUser?.emailVerified;
  //   return isVerified;
  // }

  //
  //

  // @override
  // Future<void> verifyMail() async {
  //   await _firebaseAuth.currentUser?.sendEmailVerification();
  // }

  //
  //

  @override
  bool? isAnonim() {
    debugPrint("isAnonim: [${_firebaseAuth.currentUser?.isAnonymous}]");
    return _firebaseAuth.currentUser?.isAnonymous;
  }

  //
  //

  @override
  Future<void> setLikedPostID(AppUser user, String likedPosts) async {
    DocumentReference a = _firestore.collection("users").doc(user.id);
    await a.set({"likedPosts": likedPosts}, SetOptions(merge: true));
  }
}
