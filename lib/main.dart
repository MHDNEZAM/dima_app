import 'package:flutter/material.dart';
import 'package:dima_app/screens/welcome_screen.dart';
import 'package:dima_app/screens/login_screen.dart';
import 'package:dima_app/screens/sign_up_screen.dart';
import 'package:dima_app/screens/properties_screen.dart';
import 'package:dima_app/screens/chat_screen.dart';
import 'package:dima_app/screens/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        PropertiesScreen.id: (context) => PropertiesScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        //'test': (context) => CustomDialogBox(),
      },
    );
  }
}
