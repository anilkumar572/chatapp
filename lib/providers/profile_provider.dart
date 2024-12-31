import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String country = "";
  var db = FirebaseFirestore.instance;

  var authUser = FirebaseAuth.instance.currentUser;

  void getData() async {
    var authUser = FirebaseAuth.instance.currentUser;
    await db.collection('users').doc(authUser!.uid).get().then((dataSnapShot) {
      name = dataSnapShot.data()?['name'] ?? " ";
      email = dataSnapShot.data()?['email'] ?? " ";
      country = dataSnapShot.data()?['country'] ?? " ";
    });
    notifyListeners();
  }
}
