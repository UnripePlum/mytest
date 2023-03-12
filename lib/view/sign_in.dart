import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../model/user_model.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
            TextButton(
              onPressed: () {
                AuthController.instance.login(emailController.text.trim(),
                    passwordController.text.trim());
              },
              child: Text(
                "SignIn",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
