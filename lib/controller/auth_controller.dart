import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/controller/sign_controller.dart';
import 'package:mytest/model/user_model.dart';

import '../main.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  static var curUser = <UserModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
    } else {
      Get.back();
    }
  }

  void register(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await authentication.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password);
      userCredential.user?.updateDisplayName(userModel.username);
      reloadUser(userModel);
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
          "email : ${userModel.email}, password : ${userModel.password}, name : ${userModel.username}",
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
  }

  void reloadUser(UserModel userModel) {
    curUser.assign(userModel);
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await authentication
          .signInWithEmailAndPassword(email: email, password: password);
      User tempUser = userCredential.user as User;
      UserModel userModel = new UserModel(email, password, tempUser.displayName as String);
      reloadUser(userModel);


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
          "email : ${userModel.email}, password : ${userModel.password}, name : ${userModel.username}",
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
