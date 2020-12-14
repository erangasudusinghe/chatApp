import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController frogetPasswodController =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
       body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Enter Your Email to rest your Password',),
                          ],
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          controller: frogetPasswodController,
                            style: blackTextstyle(),
                            decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            isDense: true,
                            contentPadding: EdgeInsets.all(2),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                        helperText: "example@gmail.com"),
                        ),
                        SizedBox(height: 20,),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 45.0,
                          child: RaisedButton(onPressed: (){
                            AuthonticationMethod().resetPassword(frogetPasswodController.text);
                          },
                          
                          color: Colors.green,
                          child: Text('Reset',style:TextStyle(color: Colors.white,fontSize: 18,),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}