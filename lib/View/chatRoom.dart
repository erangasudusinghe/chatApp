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
import 'package:chatbar/chatbar.dart';

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
      appBar:new ChatBar( 
          height: 64,
          profilePic: Image.asset(
            "asset/images/Eranga.jpg",
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          username: Constants.Name,
          status: Text(''),
          color: Colors.green.shade400,
          backbuttoncolor: Colors.white,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              enabled: true,
              onSelected: (str) {},
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'View Contact',
                  child: Text('My Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'Media',
                  child: Text('Log Out'),
                ),
              ],
            )
          ],
        ),
      /*AppBar(
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
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage ("asset/images/logout.png"), 
                  )
                ), 
              ),
          ),
        ],
      ),*/
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
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> Conversation(chatRoom),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1 ,horizontal:0 ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 150,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Container(
             decoration: BoxDecoration(
                    gradient:LinearGradient(
                        colors:[
                            const Color(0xffffffff),
                            const Color(0x33ffffff),
                              ],
                     ),
              ),
            child: Row(
              children: [
                Container(
                  height: 55,
                  width: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
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
                  child: Text("${name.substring(0,1).toUpperCase()}", style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
                Container(
                  //color: Colors.cyan,
                  width: 265,
                  margin: EdgeInsets.all(14),
                  child: Column(
                    children:[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
                        child: Text(name,style: TextStyle(fontSize: 18,color: Colors.black54),)
                        ),
                      Divider(color: Colors.black54,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
