import 'auth.dart';
import 'pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'pages/homePage.dart';

//Changes the diplayed page based on current Auth state, if the user signs out or Auth state changes unexpectedly
//the page would be notified and would redirect back to the login page
class AuthTree extends StatefulWidget {
  const AuthTree({super.key});

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyHomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
