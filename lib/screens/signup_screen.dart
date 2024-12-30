import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gchat/controllers/signup_controller.dart';
import 'package:gchat/screens/dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  final userkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: userkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                      TextFormField(
                        controller: name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Name Cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('Name'),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      TextFormField(
                        controller: country,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Country Cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('Country'),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 50, 163, 255),
                                  minimumSize: Size(0, 50),
                                ),
                                onPressed: () {
                                  if (userkey.currentState!.validate()) {
                                    SignUpController.createAccount(
                                        email: email.text,
                                        password: password.text,
                                        name: name.text,
                                        country: country.text,
                                        context: context);
                                  }
                                },
                                child: Text('Signup')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
