import 'package:chat/services/Supportivefunction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  getUserByUserName(String UserName)async{
    return await Firestore.instance.collection("users").where("UserName",isEqualTo: UserName).getDocuments();
  }
  getUserByUserEmail(String Email)async{
    return await Firestore.instance.collection("users").where("email",isEqualTo: Email).getDocuments();
  }
  getUserProfile(String email)async{
    return await Firestore.instance.collection("UserDetails").where("Email",isEqualTo: email).getDocuments();
  }
  UploadUserInfo(useMap)
  {
    Firestore.instance.collection("users").add(useMap).catchError((e){
      print(e.toString());
    });
  }
  uploadProfileInfo(useMap)async
  {
    String userEmail=await HelperFunctons.getUserEmail();
    Firestore.instance.collection("UserDetails").document(userEmail).setData(useMap).catchError((e){
      print(e.toString());
    });
  }
  
  CreateChatRoomData(String chatRoomId,ChatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(ChatRoomMap).catchError((e) {
      print(e.toString());
    });
  }
  setChatRoomMessages(String chatroomId, ChatMap){
    Firestore.instance.collection("ChatRoom").document(chatroomId).collection("Chats").add(ChatMap).catchError((e){print(e.toString());});
  }
  getChatRoomMessages(String chatroomId) async{
    return await Firestore.instance.collection("ChatRoom").document(chatroomId).collection("Chats").orderBy("time").snapshots();
  }
  getUserChatRoom(String name)async{
    return await Firestore.instance.collection("ChatRoom").where("users",arrayContains: name).snapshots();
  }
  

}
