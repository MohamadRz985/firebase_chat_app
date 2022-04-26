import 'package:firebase_chat_make/helper/authenticat.dart';
import 'package:firebase_chat_make/helper/myconstanst.dart';
import 'package:firebase_chat_make/helper/sphelper.dart';
import 'package:firebase_chat_make/screens/conversationpage.dart';
import 'package:firebase_chat_make/screens/search.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:firebase_chat_make/widgets/myWidgets.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods auth = AuthMethods();
  DatabaseMethods dbm = DatabaseMethods();
  Stream? chatRoomsStream;

  //!Widget for calling chatrooms list =======

  Widget chatRoomLists() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index]
                        .data()["chatroomId"]
                        .toString()
                        .replaceAll(
                          "_",
                          "",
                        )
                        .replaceAll(MyConstants.myName, ""),
                    chatRoomId: snapshot.data.docs[index].data()["chatroomId"],
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    MyConstants.myName = (await SPHelper.getUserNameSharedPref())!;
    dbm.getChatRooms(MyConstants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBlueColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Authenticate()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 3.8),
            child: const Text(
              "Chats",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: mainBlueColor,
        ),
        body: chatRoomLists(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print("Search Tapped");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
          child: const Icon(
            Icons.message,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ));
  }
}

//! Tile For Chatrooms List ==============
class ChatRoomsTile extends StatelessWidget {
  const ChatRoomsTile(
      {Key? key, required this.userName, required this.chatRoomId})
      : super(key: key);
  final String userName;
  final String chatRoomId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationPage(chatRoomId: chatRoomId)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: mainRedColor, borderRadius: BorderRadius.circular(40)),
              child: Text(
                userName.substring(0, 1).toUpperCase(),
                style: largeBlackTextStyle(),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(userName, style: largeBlackTextStyle()
                // const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
          ],
        ),
      ),
    );
  }
}
