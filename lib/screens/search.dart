import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_make/helper/authenticat.dart';
import 'package:firebase_chat_make/screens/chatRoom.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:firebase_chat_make/widgets/myWidgets.dart';
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

  //!SearchList Making ====================
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userEmail: searchSnapshot!.docs[index].get("userEmail"),
                userName: searchSnapshot!.docs[index].get("userName"),
              );
            },
            itemCount: searchSnapshot!.docs.length)
        : Container();
  }

  //! Create Chatroom ,send User to conversation ========

  // createChatroomStartConversation(String userName) {

  //   List<String> users = [userName,]
  //   dbm.createChatRoom();
  // }

  //!Making Search Function (This Value is _JsonQuerySnapshot )======
  initialeSearch() {
    dbm.getUsersbyUserName(searchUserText.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // initialeSearch();
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

//! widget for making searchlist Tile ============

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, this.userEmail, this.userName}) : super(key: key);

  final String? userName;
  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName!,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(userEmail!)
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
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
}
