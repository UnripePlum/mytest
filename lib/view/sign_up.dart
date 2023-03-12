import 'package:flutter/material.dart';
import 'package:mytest/controller/auth_controller.dart';
import 'package:mytest/model/user_model.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              color: Colors.black12,
              height: 60,
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "email"),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              color: Colors.black12,
              height: 60,
              width: 300,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "password"),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              color: Colors.black12,
              height: 60,
              width: 300,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: "username"),
              ),
            ),
            TextButton(
              onPressed: () {
                UserModel userModel = UserModel(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    username: usernameController.text.trim());
                AuthController.instance.register(userModel);
              },
              child: Text(
                "SignUp",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
