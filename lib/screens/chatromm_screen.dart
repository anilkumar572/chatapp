import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ChatRoomScreeen extends StatefulWidget {
  ChatRoomScreeen({super.key, required this.title, required this.chatroomid});

  String title;
  String chatroomid;

  @override
  State<ChatRoomScreeen> createState() => _ChatRoomScreeenState();
}

class _ChatRoomScreeenState extends State<ChatRoomScreeen> {
  TextEditingController msgtext = TextEditingController();
  var db = FirebaseFirestore.instance;
  var authuser = FirebaseAuth.instance.currentUser;
  Future<void> sendMessage() async {
    if (msgtext.text.isEmpty) {
      return;
    }
    Map<String, dynamic> msgToSend = {
      'text': msgtext.text,
      'sender_name': Provider.of<DataProvider>(context, listen: false).name,
      'chatroom_id': widget.chatroomid,
      'sender_id': authuser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await db.collection('messages').add(msgToSend);
      msgtext.text = "";
    } catch (e) {
      print(e);
    }
  }

  Widget singleChildlist(
      {required String sender_name,
      required String text,
      required String sender_id}) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Column(
        crossAxisAlignment: (sender_id == authuser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender_name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
              decoration: BoxDecoration(
                color: (sender_id == authuser!.uid)
                    ? Colors.grey[300]
                    : Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: (sender_id == authuser!.uid)
                          ? Colors.black
                          : Colors.white),
                ),
              )),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: db
                      .collection('messages')
                      .where('chatroom_id', isEqualTo: widget.chatroomid)
                      .orderBy("timestamp", descending: true)
                      .limit(100)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Some error occured");
                    }

                    var allMessages = snapshot.data?.docs ?? [];
                    if (allMessages.length < 1) {
                      return Center(
                        child: Text("No messages here"),
                      );
                    }
                    return ListView.builder(
                        reverse: true,
                        itemCount: allMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: singleChildlist(
                                sender_name: allMessages[index]['sender_name'],
                                text: allMessages[index]['text'],
                                sender_id: allMessages[index]['sender_id']),
                          );
                        });
                  })),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: msgtext,
                    decoration: InputDecoration(
                        hintText: "write Message here...?",
                        border: InputBorder.none),
                  )),
                  InkWell(onTap: sendMessage, child: Icon(Icons.send)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
