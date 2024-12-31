import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/main.dart';
import 'package:gchat/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic>? userdata = {};

  var db = FirebaseFirestore.instance;

  var authUser = FirebaseAuth.instance.currentUser;

  TextEditingController edit_name = TextEditingController();

  var formkey = GlobalKey<FormState>();

  void updateData() {
    Map<String, dynamic> data = {
      'name': edit_name.text,
    };
    db.collection("users").doc(authUser!.uid).update(data);
    Provider.of<DataProvider>(context, listen: false).getData();
    Navigator.pop(context);
  }

  @override
  void initState() {
    edit_name.text = Provider.of<DataProvider>(context, listen: false).name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var val = context.read<DataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    updateData();
                  }
                },
                child: Icon(Icons.check)),
          )
        ],
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Name must not be empty";
                  }
                },
                controller: edit_name,
                decoration: InputDecoration(label: Text("Name")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
