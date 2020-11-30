import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
class Tservice extends StatefulWidget {
  GoogleTranslator translator =GoogleTranslator();
  translate(BuildContext context, String text){
        translator.translate(text, to :"si").then((value){
             String message=value.toString();
              print(message);
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
          });
     }
  @override
  _TserviceState createState() => _TserviceState();
}

class _TserviceState extends State<Tservice> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
  
  
  
