import 'package:chat/View/FrogetPasswordPage.dart';
import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Cons.dart';
import 'package:chat/services/InternetConnection.dart';
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
  if(Constants.isconnected){
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
    else{
      connectionError(context);
    }
  }
 connectionError(BuildContext context){
       return showDialog(context: context,builder: (context){
          return AlertDialog(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                height: 100,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text('Disconnected from internet connection, Please check the connection'),
                    ],
                  ),
                ),
              ),
              );
            });
          
             
    }
  @override
  void initState() {
    InternetConnection().checkConnection(context);
    super.initState();
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
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(  
                                      validator: (val){
                                        RegExp regExp = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false, multiLine: false,);
                                        return regExp.hasMatch(val) ? null : "Please Enter Valid Email";
                                      },
                                      controller: EmailEditingController,
                                      style: blackTextstyle(),
                                       decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: "example@gmail.com"
                                    ),
                                    ),
                                  ),
                                ),
                            ),
                            SizedBox(height: 10,),
                              Container(
                                child: Container(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(  
                                      validator: (val){
                                          return val.isEmpty|| val.length<8 ? "Invalid Password": null;
                                      },
                                      controller: PasswordEditingController,
                                      style: blackTextstyle(),
                                       decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: ""
                                    ),
                                    obscureText: true,
                                    ),
                                  ),
                                ),
                            ),
                            
                          ],
                        ),
                      ),
                      Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                                child: Text("Forgot Password?",style: blackTextstyle(),),
                                 ),
                              GestureDetector(
                                 onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset(),
                                    ));
                                  },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8,2,8,2),
                                  child: Text('Click'),
                                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(50), ),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(height: 16,),
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
