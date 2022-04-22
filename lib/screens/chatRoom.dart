import 'package:firebase_chat_make/helper/authenticat.dart';
import 'package:firebase_chat_make/screens/search.dart';
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
        backgroundColor: Colors.grey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Authenticate()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              )),
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
            child: const Text(
              "Chat Rooms ",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print("Search Tapped");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
          child: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          backgroundColor: Colors.white,
        ));
  }
}
