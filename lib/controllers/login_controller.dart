import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/screens/dashboard.dart';
import 'package:gchat/screens/splash_screen.dart';

class LoginController {
  static Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SplashScreen();
      }));
    } catch (e) {
      SnackBar bar = SnackBar(content: Text(e.toString()));

      ScaffoldMessenger.of(context).showSnackBar(bar);
    }
  }
}
