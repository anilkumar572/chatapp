import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/main.dart';
import 'package:gchat/providers/profile_provider.dart';
import 'package:gchat/screens/chatromm_screen.dart';
import 'package:gchat/screens/login_screen.dart';
import 'package:gchat/screens/profile_page.dart';
import 'package:gchat/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var user = FirebaseAuth.instance.currentUser;

  var scaffoldkey = GlobalKey<ScaffoldState>();

  var db = FirebaseFirestore.instance;

  var authUser = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> chatroomList = [];
  List<String> chatroomsIds = [];

  void getChatRooms() async {
    await db.collection('chatrooms').get().then((datasnapchat) {
      for (var singlechat in datasnapchat.docs) {
        chatroomList.add(singlechat.data());
        chatroomsIds.add(singlechat.id.toString());
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var val = context.watch<DataProvider>();
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              scaffoldkey.currentState!.openDrawer();
            },
            child: CircleAvatar(
              child: Text(val.name[0]),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text(val.name[0]),
              ),
              title: Text(val.name),
              subtitle: Text(val.email),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }),
                );
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log out"),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: chatroomList.length,
          itemBuilder: (BuildContext context, int index) {
            var chatname = chatroomList[index]['chatroom_name'];
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatRoomScreeen(
                    chatroomid: chatroomsIds[index],
                    title: chatname,
                  );
                }));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey[900],
                  child: Text(
                    chatname[0] ?? " ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              title: Text(chatname ?? " "),
              subtitle: Text(chatroomList[index]['desc'] ?? " "),
            );
          }),
    );
  }
}
