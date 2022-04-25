import 'package:cloud_firestore/cloud_firestore.dart';
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
  //Stream? chatMessageStream;
  Stream? chats;

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["message"],
                    sendByMe: MyConstants.myName ==
                        snapshot.data.docs[index].data()["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  //! E4 . Returning Chat List ==============
  // Widget chatMessageList() {
  //   return StreamBuilder(
  //     builder: ((context, AsyncSnapshot<dynamic> snapshot) {
  //       return ListView.builder(
  //         itemCount: snapshot.data.length,
  //         itemBuilder: (context, index) {
  //           return MessageTile(message: snapshot.data![index]["message"]);
  //         },
  //       );
  //     }),
  //     stream: chatMessageStream,
  //   );
  // }

  //! E4 . for sending messages ==========
  sendMessages() {
    if (messageInputController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageInputController.text,
        "sendBy": MyConstants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      dbm.addConversationMessages(widget.chatRoomId, messageMap);
      messageInputController.text = " ";
    }
  }

  @override
  void initState() {
    //! call this for returning prev messages =====
    dbm.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chats = value;
      });
    });
    super.initState();
    // chatMessageList();
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
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            // Container(
            //     height: 50,
            //     width: MediaQuery.of(context).size.width,
            //     child: chatMessageList()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      ),
    );
  }
}

//! MessageTile ==============
class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message, required bool sendByMe})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
