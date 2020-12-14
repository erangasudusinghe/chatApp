

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:progress_dialog/progress_dialog.dart';
class Tservice extends StatefulWidget {
  GoogleTranslator translator =GoogleTranslator();
  String message;
  translate(BuildContext context, String text){
         ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true,);
            pr.style(
                    message: 'Translating...',
                    borderRadius: 10.0,
                    backgroundColor: Colors.white,
                    progressWidget: CircularProgressIndicator(),
                    elevation: 10.0,
                    insetAnimCurve: Curves.easeInOut,
                    progressTextStyle: TextStyle(
                      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                    messageTextStyle: TextStyle(
                      color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600)
                    );
        translator.translate(text, to :"si").then((value){
              message=value.toString();
              print(message);
              pr.hide();
              translateShow(context);
             
          });
        if(message==null){
            pr.show();
        }
     }
    
    translateShow(BuildContext context){
       return showDialog(context: context,builder: (context){
                return AlertDialog(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Translated Message")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                height: 200,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(message),
                    ],
                  ),
                ),
              ),
              );
            });
      }
  @override
  _TserviceState createState() => _TserviceState();
}

class _TserviceState extends State<Tservice> {
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
  
  
  
