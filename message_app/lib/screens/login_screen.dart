import 'package:flutter/material.dart';
import 'package:message_app/widget/login_form.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const LoginForm(),
    );
  }
}