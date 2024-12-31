import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gchat/controllers/login_controller.dart';
import 'package:gchat/controllers/signup_controller.dart';
import 'package:gchat/screens/dashboard.dart';
import 'package:gchat/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final userkey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: userkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/logo.png'),
                ),
                TextFormField(
                  controller: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Email Cannot be empty';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                TextFormField(
                  controller: password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Password Cannot be empty';
                    }
                  },
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    label: Text('Password'),
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(0, 50),
                    ),
                    onPressed: () async {
                      if (userkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        LoginController.login(
                            email: email.text,
                            password: password.text,
                            context: context);
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                  ),
                ),
                Row(
                  children: [
                    Text('Dont have an account!'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpScreen();
                        }));
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
