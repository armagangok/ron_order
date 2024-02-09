import 'package:flutter/material.dart';

class LoginTextController {
  
  final TextEditingController _username =
      TextEditingController();
  final TextEditingController _password =
      TextEditingController();

  TextEditingController get passwordController => _password;
  TextEditingController get emailController => _username;
}
