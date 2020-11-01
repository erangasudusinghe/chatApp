import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatRoom.dart';


class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  AuthonticationMethod authonticationMethod =new AuthonticationMethod();
  TextEditingController EmailEditingController =new TextEditingController();
  TextEditingController PasswordEditingController =new TextEditingController();
  Database database = new Database();
  bool isLoading= false;
  QuerySnapshot snapshot;
  signIn(){
    if(formkey.currentState.validate()){
      HelperFunctons.SaveUserEmail(EmailEditingController.text);
      setState(() {
        isLoading=true;
      });
      database.getUserByUserEmail(EmailEditingController.text).then((val){
        snapshot=val;
        print("${snapshot.documents[0].data["UserName"].toString()}");
        HelperFunctons.SaveUserName(snapshot.documents[0].data["UserName"].toString());

      });
      authonticationMethod.SignInWithEmailAndPassword(EmailEditingController.text, PasswordEditingController.text).then((value){
        if(value!=null) {
          HelperFunctons.SaveUserLogin(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom(),
          ));
        }
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack( // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/signupBackground.png"),
              ),
          ),
        ),
    Scaffold(
      backgroundColor: Colors.white,
      body:isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(
        child: Container(
           padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Container(
              alignment: Alignment.bottomCenter,
              height: 230,
              width:230 ,
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/images/signupBackground.png"),
              ),
            ),
              ),
              Container(
               // height: MediaQuery.of(context).size.height-50 ,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24) ,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Container(
                                child: Container(
                                  height: 40,
                                  child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                    image:AssetImage("asset/images/email.png"),
                                    alignment:Alignment.centerLeft,
                                    ), 
                                    borderRadius: BorderRadius.circular(50),
                                     boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                         ),
                                     ],
                                  ),

                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 70),
                                    child: TextFormField(  
                                      validator: (val){
                                        RegExp regExp = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false, multiLine: false,);
                                        return regExp.hasMatch(val) ? null : "Please Enter Valid Email";
                                      },
                                      controller: EmailEditingController,
                                      style: blackTextstyle(),
                                      decoration: InputDecorationTextField("Email"),
                                    ),
                                  ),
                              ),
                                ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                                  height: 40,
                                  child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                  image:AssetImage("asset/images/lock.png"),
                                  alignment: Alignment.centerLeft,
                                  ), 
                                  borderRadius: BorderRadius.circular(50),
                                   boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                       ),
                                   ],
                                ),
                                  child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 70),
                                  child: TextFormField(
                                    validator: (val){
                                      return val.isEmpty|| val.length<8 ? "Invalid Password": null;
                                    },
                                    controller: PasswordEditingController,
                                    style: blackTextstyle(),
                                    decoration: InputDecorationTextField("Password"),
                                    obscureText: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 4,),
                      Container(
                        alignment: Alignment.centerRight,
                          child:Container(
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            child: Text("Forgot Password?",style: blackTextstyle(),),
                          )
                      ),
                      SizedBox(height: 4,),
                      GestureDetector(
                        onTap: (){
                          signIn();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient:LinearGradient(
                                  colors:[
                                    const Color(0xff008866),
                                    const Color(0xff009810),
                                  ],
                              ),
                            borderRadius: BorderRadius.circular(50),
                             boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                   ),
                               ],
                          ),
                          child: Text("SignIn",style: simpleTextstyle(),),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient:LinearGradient(
                            colors:[
                              const Color(0xffffffff),
                              const Color(0xfffffff8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                   ),
                               ],
                        ),
                        child: Text("Sign in With Google",style: TextStyle(
                          color: Colors.black
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),),
                          GestureDetector(
                            onTap: (){
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text("Create",style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )]);
  }
}
