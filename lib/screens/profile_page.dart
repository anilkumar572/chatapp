import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/main.dart';
import 'package:gchat/providers/profile_provider.dart';
import 'package:gchat/screens/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userdata = {};

  var db = FirebaseFirestore.instance;

  var authUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var val = context.watch<DataProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                val.name[0].toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              val.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              val.email,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfile();
                  }));
                },
                child: Text("Edit Profile"))
          ],
        ),
      ),
    );
  }
}
