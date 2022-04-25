import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUsersbyUserName(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: userName)
        .get();
  }

  getUsersbyUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: userEmail)
        .get();
  }

  uploadUserData(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatroomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatroomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e);
    });
  }

  //! Method for sending messages from database ======
  addConversationMessages(String chatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatroomId) async {
    return await FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatroomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
