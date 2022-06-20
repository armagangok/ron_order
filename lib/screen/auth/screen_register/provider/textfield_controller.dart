import 'package:flutter/material.dart';

class RegisterTextController {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

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
