import 'package:domestico/Home/home_screen.dart';
import 'package:domestico/SharedPrefrence/SharedPref.dart';
import 'package:domestico/login&register/Login_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
