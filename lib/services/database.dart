import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUsersbyUserName(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: userName)
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
}
