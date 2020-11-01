import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget AppbarMain(BuildContext context){
  return AppBar(
      title: Image.asset("asset/images/logo.png", height: 50,),
      backgroundColor: Colors.lime,
  );
}
InputDecoration InputDecorationTextField(String hint)
{
  return InputDecoration(
      hintText:hint,
      hintStyle: TextStyle(
        color: Colors.black26,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:BorderSide(color:Colors.white),
      ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    )
  );
}
TextStyle simpleTextstyle(){
  return TextStyle(color: Colors.white);
}
TextStyle blackTextstyle(){
  return TextStyle(color: Colors.black54);
}