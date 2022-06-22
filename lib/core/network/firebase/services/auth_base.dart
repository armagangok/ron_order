import '../models/user_model.dart';

abstract class AuthBase {
  Future<AppUser?> currentUser();
  // Future<AppUser?> signinAnonim();
  Future<bool> logout();
  // Future<AppUser?> signInByGoogle();
  Future<AppUser?> login(String email, String password);
  Future<AppUser?> register(AppUser appUser);
  // bool? isVerified();
  // Future<void> verifyMail();
  // bool? isAnonim();
  Future<void> setLikedPostID(AppUser user, String likedPost);
}
