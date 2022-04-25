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

//! E4 . Returning Chat List ==============
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
                    isSendByMe: MyConstants.myName ==
                        snapshot.data.docs[index].data()["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

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
      backgroundColor: Colors.grey,
      //!AppBar ==========================
      appBar: AppBar(
        elevation: 0,
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
            "Let`s Talk  ",
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
              // color: Colors.grey,
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
                          //  enableInteractiveSelection: true,
                          controller: messageInputController,
                          decoration: const InputDecoration(
                              // hoverColor: Colors.black,
                              hintText: "Message",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
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
                          icon: const Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                          ))
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

//! MessageTile and shape ==============
class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.isSendByMe,
  }) : super(key: key);
  final String message;
  final bool isSendByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 15, right: isSendByMe ? 15 : 0),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            color: isSendByMe ? Colors.green : Colors.blue,
            borderRadius: isSendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24))
                : const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
        child: Text(
          message,
          style: const TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color.fromARGB(255, 255, 251, 251)),
        ),
      ),
    );
  }
}
