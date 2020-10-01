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
    return Scaffold(
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
        onPressed: ()
        {
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=>SearchScreen(),
            ));
        },
      ),
    );
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
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.limeAccent,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${name.substring(0,1).toUpperCase()}", style: simpleTextstyle()),
            ),
            SizedBox(width: 8,),
            Text(name,style: simpleTextstyle()),
          ],
        ),
      ),
    );
  }
}
