import 'package:flutter/material.dart';

class LoginTextController {
  final TextEditingController _username =
      TextEditingController(text: "1armagangok@gmail.com");
  final TextEditingController _password =
      TextEditingController(text: "1234567");

  TextEditingController get passwordController => _password;
  TextEditingController get emailController => _username;
}
