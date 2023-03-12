import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/model/user_model.dart';

import '../main.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth authentication = FirebaseAuth.instance;
  static var curUser = <UserModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {} else {
      reloadUser(userToUserModel(user));
      Get.back();
    }
  }

  UserModel userToUserModel(User user) {
    return UserModel(
      email: user.email as String,
      username: user.displayName as String,
    );
  }

  void register(UserModel userModel) async {
    try {
      UserCredential userCredential =
      await authentication.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password as String);
      userCredential.user?.updateDisplayName(userModel.username);
      reloadUser(userToUserModel(userCredential.user as User));
      Get.snackbar(
        "Success message",
        "User message",
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Registration success",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          "email : ${userCredential.user?.email}, name : ${userCredential.user
              ?.displayName}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Registration is failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void logout() {
    authentication.signOut();
    curUser.clear();
  }

  void reloadUser(UserModel userModel) {
    curUser.assign(userModel);
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await authentication
          .signInWithEmailAndPassword(email: email, password: password);
      User tempUser = userCredential.user as User;
      reloadUser(userToUserModel(tempUser));

      Get.snackbar(
        "Success message",
        "User message",
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login success",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          "email : ${tempUser.email}, name : ${tempUser.displayName}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login is failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
