import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/providers/profile_provider.dart';
import 'package:gchat/screens/dashboard.dart';
import 'package:gchat/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var current_user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // TODO: implement initState
      if (current_user == null) {
        login();
      } else {
        opendashboard();
      }
    });

    super.initState();
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }),
    );
  }

  void opendashboard() {
    Provider.of<DataProvider>(context, listen: false).getData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return DashBoard();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
