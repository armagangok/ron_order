import 'package:flutter/material.dart';

class RegisterTextController {
  final TextEditingController _usernameController =
      TextEditingController(text: "Armağan");
  final TextEditingController _emailController =
      TextEditingController(text: "1armagangok@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "1234567");
  final TextEditingController _rePasswordController =
      TextEditingController(text: "1234567");

  TextEditingController get username => _usernameController;
  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  TextEditingController get rePassword => _rePasswordController;

  // set setUsernameCont(TextEditingController controller) =>
  //     _usernameController = controller;

  // set setEmailCont(TextEditingController controller) =>
  //     _emailController = controller;

  // set setPasswordCont(TextEditingController controller) =>
  //     _passwordController = controller;

}
