import '../locator/locator.dart';
import '../models/user_model.dart';
import '../services/auth_base.dart';
import '../services/current_service.dart';
import '../services/dummy_service.dart';

enum AppMode { debug, release }

class UserRepository implements AuthBase {
  final CurrentService _authService = locator<CurrentService>();
  final DummyService _dummyAuthService = locator<DummyService>();

  AppMode appMode = AppMode.release;

  @override
  Future<AppUser?> currentUser() async {
    if (appMode == AppMode.debug) {
      return await _dummyAuthService.currentUser();
    } else {
      return _authService.currentUser();
    }
  }

  @override
  Future<bool> logout() async {
    if (appMode == AppMode.debug) {
      return await _dummyAuthService.logout();
    } else {
      return await _authService.logout();
    }
  }

  @override
  Future<AppUser?> signinAnonim() async {
    if (appMode == AppMode.debug) {
      return await _dummyAuthService.signinAnonim();
    } else {
      return await _authService.signinAnonim();
    }
  }

  // @override
  // Future<AppUser?> signInByGoogle() async {
  //   if (appMode == AppMode.debug) {
  //     return await _dummyAuthService.signInByGoogle();
  //   } else {
  //     return await _authService.signInByGoogle();
  //   }
  // }

  @override
  Future<AppUser?> loginByEmailPassword(
    String email,
    String password,
  ) async {
    if (appMode == AppMode.debug) {
      return await _dummyAuthService.loginByEmailPassword(email, password);
    } else {
      return await _authService.loginByEmailPassword(email, password);
    }
  }

  @override
  Future<AppUser?> createUserByEmailPassword(AppUser user) async {
    if (appMode == AppMode.debug) {
      return await _dummyAuthService.createUserByEmailPassword(user);
    } else {
      final AppUser? renewedUser =
          await _authService.createUserByEmailPassword(user);
      return renewedUser;
    }
  }

  // @override
  // bool? isVerified() {
  //   if (appMode == AppMode.debug) {
  //     return _dummyAuthService.isVerified();
  //   } else {
  //     return _authService.isVerified();
  //   }
  // }

  // @override
  // Future<void> verifyMail() async {
  //   if (appMode == AppMode.debug) {
  //     await _dummyAuthService.verifyMail();
  //   } else {
  //     await _authService.verifyMail();
  //   }
  // }

  @override
  bool? isAnonim() {
    if (appMode == AppMode.debug) {
      return _dummyAuthService.isAnonim();
    } else {
      return _authService.isAnonim();
    }
  }

  @override
  Future<void> setLikedPostID(AppUser user, String likedPosts) async {
    if (appMode == AppMode.debug) {
      await _dummyAuthService.setLikedPostID(user, likedPosts);
    } else {
      await _authService.setLikedPostID(user, likedPosts);
    }
  }
}
