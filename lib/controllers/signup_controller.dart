import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController {
  static Future<void> createAccount(
      {required String email,
      required String password,
      required String name,
      required String country,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userid = FirebaseAuth.instance.currentUser!.uid;

      var db = FirebaseFirestore.instance;

      Map<String, dynamic> data = {
        'name': name,
        'country': country,
        'email': email,
        'id': userid.toString(),
      };
      try {
        await db.collection('users').doc(userid.toString()).set(data);
      } catch (e) {
        print(e);
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DashBoard();
      }));
    } catch (e) {
      SnackBar bar = SnackBar(content: Text(e.toString()));

      ScaffoldMessenger.of(context).showSnackBar(bar);
    }
  }
}
