import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget AppbarMain(BuildContext context){
  return AppBar(
      title: Image.asset("asset/images/logo.png", height: 50,),
      backgroundColor: Colors.green,
  );
}
InputDecoration InputDecorationTextField(String hint)
{
  return InputDecoration(
      hintText:hint,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:BorderSide(color:Colors.white54),
      ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    )
  );
}
TextStyle simpleTextstyle(){
  return TextStyle(color: Colors.white);
}