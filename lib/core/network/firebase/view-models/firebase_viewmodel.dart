import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../locator/locator.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';
import '../services/auth_base.dart';

enum ViewState { idle, busy }

class FirebaseVmodel with ChangeNotifier implements AuthBase {
  final UserRepository _userRepository = locator<UserRepository>();

  AppUser? _user;
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  AppUser? get user => _user;
  bool isPasswordCorrect = true;
  bool isMailCorrect = true;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  FirebaseVmodel() {
    currentUser();
  }

  @override
  Future<AppUser?> currentUser() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.currentUser();
      return _user;
    } on FirebaseException catch (e) {
      debugPrint("$e");
      return null;
    } finally {
      state = ViewState.idle;
    } //finally runs wheter or not an error.
  }

  @override
  Future<bool> logout() async {
    try {
      state = ViewState.busy;
      bool credential = await _userRepository.logout();
      _user = null;
      return credential;
    } on FirebaseException catch (e) {
      debugPrint("$e");
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<AppUser?> signinAnonim() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signinAnonim();
      debugPrint("userViewModel user:  $_user");
      return _user;
    } on FirebaseException catch (e) {
      debugPrint("$e");
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  // @override
  // Future<AppUser?> signInByGoogle() async {
  //   try {
  //     state = ViewState.busy;
  //     _user = await _userRepository.signInByGoogle();
  //     return _user;
  //   } catch (e) {
  //     debugPrint(
  //         "Error in FirebaseViewmodel, at signInByGoogle() method. \n [$e]");
  //     return null;
  //   } finally {
  //     state = ViewState.idle;
  //   }
  // }

  @override
  Future<AppUser?> createUserByEmailPassword(AppUser user) async {
    if (emailControl(user.email!)) {
      try {
        // passwordControll(user.password!, user.passwordRepeat!);
        AppUser? response =
            await _userRepository.createUserByEmailPassword(user);
        // await verifyMail();

        return response;
      } on FirebaseException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      return null;
    }
  }

  //

  @override
  Future<AppUser?> loginByEmailPassword(
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
    } else {
      try {
        state = ViewState.busy;
        _user = await _userRepository.loginByEmailPassword(
          email,
          password,
        );
        return _user;
      } on FirebaseException catch (e) {
        debugPrint("$e.message");
        return null;
      } finally {
        state = ViewState.idle;
      }
    }
    return null;
  }

  //

  // @override
  // bool? isVerified() {
  //   return _userRepository.isVerified();
  // }

  // @override
  // Future<void> verifyMail() async {
  //   try {
  //     await _userRepository.verifyMail();
  //   } catch (e) {
  //     debugPrint("Error in FirebaseViewmodel, at verifyMail() method. \n [$e]");
  //   }
  // }

  @override
  bool? isAnonim() {
    debugPrint(
        "FirebaseViewmodel , at isANonim \n ${_userRepository.isAnonim()}");
    return _userRepository.isAnonim();
  }

  bool emailControl(String email) {
    if (email.contains("@")) {
      return true;
    } else {
      return false;
    }
  }

  //

  @override
  Future<void> setLikedPostID(AppUser user, String likedPost) async {
    await _userRepository.setLikedPostID(user, likedPost);
  }

  // bool passwordControll(String password1, String password2) {
  //   if (password1 == password2 && password1.length > 6) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

}
