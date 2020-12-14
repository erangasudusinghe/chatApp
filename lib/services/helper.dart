import 'package:chat/View/signIn.dart';
import 'package:chat/View/signUp.dart';
import 'package:flutter/material.dart';
class AuthHelp extends StatefulWidget {
  @override
  _AuthHelpState createState() => _AuthHelpState();
}

class _AuthHelpState extends State<AuthHelp> {
  bool signIn= true;
  @override
  Widget build(BuildContext context) {
    if(signIn) {
      return SignIn(toggleView);
    }
    else{
      return SignUp(toggleView);
    }
  }

  void toggleView()
  {
    setState(() {
      signIn=!signIn;
    });
  }
}

