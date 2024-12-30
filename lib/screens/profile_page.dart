import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userdata = {};

  var db = FirebaseFirestore.instance;

  var authUser = FirebaseAuth.instance.currentUser;

  void getData() async {
    await db.collection('users').doc(authUser!.uid).get().then((dataSnapShot) {
      userdata = dataSnapShot.data();
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(userdata?['name'] ?? " "),
            Text(userdata?['country'] ?? " "),
            Text(userdata?['email'] ?? " "),
          ],
        ),
      ),
    );
  }
}
