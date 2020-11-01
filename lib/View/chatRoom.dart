import 'package:chat/View/SearchScreen.dart';
import 'package:chat/View/conversation.dart';
import 'package:chat/View/signIn.dart';
import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Cons.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
import 'package:chat/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Database database =new Database();
  AuthonticationMethod _authonticationMethod=new AuthonticationMethod();
  Stream Chatstream;
  Widget ChatRoomList()
  {
    return StreamBuilder(
      stream: Chatstream,
      builder: (context, snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return ChatRoomTile(
                snapshot.data.documents[index].data["ChatRoomID"].toString().replaceAll("_","").replaceAll(Constants.Name, ""),
                  snapshot.data.documents[index].data["ChatRoomID"]
              );
            }):Container();
      },
    );
  }
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  getUserInfo()async{
      Constants.Name=await HelperFunctons.getUserName();
      database.getUserChatRoom(Constants.Name).then((value){
        setState(() {
          Chatstream=value;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Stack( // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/chatboximage.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("asset/images/logo.png", height: 50,),
        backgroundColor: Colors.green,
        actions: [
          GestureDetector(
            onTap: (){
              _authonticationMethod.SignOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>AuthHelp(),
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: ChatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.green[800],
        onPressed: ()
        {
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=>SearchScreen(),
            ));
        },
      ),
    )]);
  }
}
class ChatRoomTile extends StatelessWidget {
  final String name;
  final String chatRoom;
  ChatRoomTile(this.name, this.chatRoom);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> Conversation(chatRoom),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15 ,horizontal:4 ),
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.limeAccent,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow:[
                            BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                   ),
                            ],
                ),
                child: Text("${name.substring(0,1).toUpperCase()}", style: blackTextstyle()),
              ),
              SizedBox(width: 8,),
              Text(name,style: blackTextstyle()),
            ],
          ),
        ),
      ),
    );
  }
}
