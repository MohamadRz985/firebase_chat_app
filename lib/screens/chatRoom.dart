import 'package:firebase_chat_make/screens/signin.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods auth = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
          child: const Text(
            "Chat Rooms ",
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
