import 'package:chat/View/conversation.dart';
import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Cons.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController SearchtextEditingController =new TextEditingController();
  Database database =new Database();
  QuerySnapshot Snapshot;
  intiateResults()
  {
    database.getUserByUserName(SearchtextEditingController.text).then((val){
      setState(() {
        Snapshot=val;
      });
    });
  }
  Widget SearchList(){
    return Snapshot!=null?ListView.builder(itemCount: Snapshot.documents.length,shrinkWrap:true,itemBuilder: (context,index){
      return SearchResults(
        UserName:Snapshot.documents[index].data["UserName"],
        Email: Snapshot.documents[index].data["email"],
      );
    }):Container();
  }
  //Create ChatRoom
  CreateChatRoom({String UserName}){
    if(UserName != Constants.Name){
      Constants.Chatter=UserName;
      String ChatroomID =getChatRoomID(UserName,Constants.Name);
      List<String> Users=[UserName,Constants.Name];
      Map<String,dynamic> chatroomMap={
        "users":Users,
        "ChatRoomID":ChatroomID,
      };
      Database().CreateChatRoomData(ChatroomID, chatroomMap);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Conversation(ChatroomID),
      ));
    }
    else{
      print("you can not sent message to you");
    }
  }

  getChatRoomID(String x,String y){
    if(x.substring(0, 1).codeUnitAt(0)>y.substring(0, 1).codeUnitAt(0)){
      return("$y\_$x");
    }
    else{
      return("$x\_$y");
    }
  }
  @override
  void initState() {
    intiateResults();
    super.initState();
  }
  Widget SearchResults({String Email, String UserName}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(UserName,style: simpleTextstyle(),),
              Text(Email,style: simpleTextstyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              CreateChatRoom(UserName: UserName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              child: Text("Message"),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body:Container(
          padding: EdgeInsets.symmetric(vertical: 1,horizontal: 1),
          child: Column(
            children: [
              Container(
                color: Colors.white30,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            controller: SearchtextEditingController,
                            decoration: InputDecoration(
                            hintText: "Search Friends",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),

                          ),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTap: (){
                          intiateResults();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xfffff7ff),
                                const Color(0xffffffff)
                              ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.search),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              SearchList()
            ],
          ),
        )
    );

  }
}



