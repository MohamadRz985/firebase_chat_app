import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_make/helper/myconstanst.dart';
import 'package:firebase_chat_make/screens/chatRoom.dart';
import 'package:firebase_chat_make/screens/conversationpage.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchUserText = TextEditingController();
  DatabaseMethods dbm = DatabaseMethods();
  AuthMethods auth = AuthMethods();
  QuerySnapshot? searchSnapshot;

  //! Create Chatroom ,send User to conversation ========

  createChatroomStartConversation(String userName) {
    if (userName != MyConstants.myName) {
      String chatroomID = getChatRoomId(userName, MyConstants.myName);
      List<String> users = [userName, MyConstants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomID
      };

      DatabaseMethods().createChatRoom(chatroomID, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationPage(
                    chatRoomId: chatroomID,
                  )));
    } else {
      print(" You Cannot Message Your Self");
      //  print(" you cannot message");
    }
  }

  //!SearchList Making ====================
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                userEmail: searchSnapshot!.docs[index].get("userEmail"),
                userName: searchSnapshot!.docs[index].get("userName"),
              );
            },
            itemCount: searchSnapshot!.docs.length)
        : Container();
  }

  //! widget for making searchlist Tile ============
  Widget searchTile({required String userName, required String userEmail}) {
    return Container(
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(userEmail)
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            createChatroomStartConversation(userName);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: const Text(
              "Message",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
          ),
        )
      ]),
    );
  }

  //!Making Search Function (This Value is _JsonQuerySnapshot )======
  initialeSearch() async {
    await dbm.getUsersbyUserName(searchUserText.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //initialeSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!AppBar ==========================
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              auth.signOut();
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
      //!Body ==============
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  //!TextFields ===================
                  child: TextField(
                    controller: searchUserText,
                    decoration: const InputDecoration(
                        hintText: "Search User Name",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      initialeSearch();
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          const SizedBox(height: 15),
          // const Divider(color: Colors.blue, height: 5, thickness: 2),

          //! Show SearchList ==========================
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: searchList()),
          )
        ],
      ),
    );
  }
}

//! E3 . Making Function to get chatroom ID =========

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b _ $a";
  } else {
    return "$a _ $b";
  }
}
