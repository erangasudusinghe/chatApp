
import 'package:chat/View/SearchScreen.dart';
import 'package:chat/View/conversation.dart';
import 'package:chat/services/Cons.dart';
import 'package:chat/View/ProfileScreen.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
import 'package:chat/services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatbar/chatbar.dart';
import 'package:chat/services/ImageUploadservice.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Database database =new Database();
  StorangeRepo storangeRepo = new StorangeRepo();
  AuthonticationMethod _authonticationMethod=new AuthonticationMethod();
  Stream Chatstream;
  String chatroomID;

 
  String url;
  getImageUrl(String location)async{
    return await Firestore.instance.collection("storage").where("location",isEqualTo: location).getDocuments();
  }
  setImage()async{
          QuerySnapshot snapshot= await getImageUrl('User/Profile/pro${Constants.Name}.jpg');
          setState(() {
             url= snapshot.documents[0].data["url"].toString();
          });
  }

  Widget ChatRoomList()
  {
    return StreamBuilder(
      stream: Chatstream,
      builder: (context, snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              chatroomID= snapshot.data.documents[index].data["ChatRoomID"].toString();
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
    setImage(); 
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
          profilePic:(url==null)?Image.asset('asset/images/user.png',height: 50,width: 50,fit: BoxFit.cover,):Image.network(url,fit: BoxFit.cover,height: 50,width: 50,),
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
              onSelected: (str) {
                 if(str=="Profile"){
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>ProfilePage(),
                  ));

                  }
                else if(str=="logout"){
                  _authonticationMethod.SignOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>AuthHelp(),
                  ));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Text('My Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Log Out'),
                ),
              ],
            )
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                        alignment: Alignment.topLeft,
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
