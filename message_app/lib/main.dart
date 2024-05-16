import 'package:flutter/material.dart';
import 'package:message_app/screens/home_screen.dart';
import 'package:message_app/screens/login_screen.dart';
import 'package:message_app/screens/user_detail_screen.dart';
import 'package:message_app/screens/user_list_screen.dart';

import 'model/message.dart';
import 'model/user.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/user-list': (context) => const UserListScreen(),
        '/login': (context) => const LoginScreen(),
//        '/user': (context) => const UserDetailScreen(user: user, messages: messages)
        }
    );
  }
}
