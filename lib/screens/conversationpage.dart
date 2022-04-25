import 'package:firebase_chat_make/helper/myconstanst.dart';
import 'package:firebase_chat_make/screens/chatRoom.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key, required this.chatRoomId})
      : super(key: key);
  final String chatRoomId;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  DatabaseMethods dbm = DatabaseMethods();
  var messageInputController = TextEditingController();

  // Widget ChatMessageList() {}

  //! E4 . for sending messages ==========
  sendMessages() {
    if (messageInputController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messageInputController.text,
        "sendBy": MyConstants.myName
      };
      dbm.getConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!AppBar ==========================
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ChatRoom()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
          child: const Text(
            "Search ",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      //! Body ===========
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      //!TextFields ===================
                      child: TextField(
                        controller: messageInputController,
                        decoration: const InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          sendMessages();
                        },
                        icon: const Icon(Icons.send_outlined))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
