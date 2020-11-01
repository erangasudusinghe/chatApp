import 'package:chat/View/ProfileScreen.dart';
import 'package:chat/services/Cons.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchScreen.dart';
class Conversation extends StatefulWidget {
  final String chatroomId;
  Conversation(this.chatroomId);
  @override
  _ConversationState createState() => _ConversationState();
}
class _ConversationState extends State<Conversation> {
  TextEditingController messagetextSendingController = new  TextEditingController();
  Database db =new Database();
  Stream messagesStrem;
  Widget MessageList(){
      return StreamBuilder(
        stream: messagesStrem,
        builder: (context,snapshot){
          if(snapshot.data == null) return Container(
              alignment: Alignment.center,
              child:CircularProgressIndicator());

          return ListView.builder( itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
              return MessageHead(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sendBy"]== Constants.Name);
          });
        },
      );
  }
  SendMessages(){
    if(messagetextSendingController.text.isNotEmpty){
      Map<String,String> ChatMap = {
        "message":messagetextSendingController.text,
        "sendBy":Constants.Name,
        "time" :DateTime.now().millisecondsSinceEpoch.toString()
      };
      db.setChatRoomMessages(widget.chatroomId,ChatMap);
      messagetextSendingController.text="";
    }
  }
  @override
  void initState() {
    db.getChatRoomMessages(widget.chatroomId).then((val){
      setState(() {
        messagesStrem=val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Profile(),
          ));
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Image.asset(
            'asset/images/logo.png',
            fit: BoxFit.contain,
            height: 60,
    ),
    Container(
    padding: const EdgeInsets.all(8.0), child: Text(widget.chatroomId.toString().replaceAll("_","").replaceAll(Constants.Name, "",)))
    ],

    ),
        ),
      ),),
      body: Container(
        child: Stack(
          children:[
            MessageList(),
            Container(
            alignment: Alignment.bottomCenter,
            child: Container(
                color: Colors.white30,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: TextField(style: TextStyle(color: Colors.white),
                          controller: messagetextSendingController,
                          decoration: InputDecoration(
                            hintText: "Type Message",
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
                          SendMessages();
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
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
    ),
      ),
    );
  }
}
class MessageHead extends StatelessWidget {
  final String Message;
  final bool isSendbyMe;
  MessageHead(this.Message,this.isSendbyMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendbyMe ? Alignment.centerRight:Alignment.centerLeft ,
      padding: EdgeInsets.only(left:isSendbyMe ? 0:10,right: isSendbyMe ? 10:0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        decoration: BoxDecoration(gradient: LinearGradient(colors: isSendbyMe ?
                [ const Color(0xff5522ff), const Color(0xff5555ff)
                ]: [ const Color(0xff5533ff), const Color(0xff5522ff)]),
                borderRadius : isSendbyMe ? BorderRadius.only(topLeft: Radius.circular(23), topRight: Radius.circular(23),bottomLeft: Radius.circular(23)) :BorderRadius.only(topLeft: Radius.circular(23),topRight: Radius.circular(23), bottomRight: Radius.circular(23))
    ),
        child: Text(Message , style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

