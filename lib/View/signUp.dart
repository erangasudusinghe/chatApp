import 'package:chat/View/chatRoom.dart';
import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthonticationMethod authonticationMethod =new AuthonticationMethod();
  TextEditingController EmailEditingController =new TextEditingController();
  TextEditingController PasswordEditingController =new TextEditingController();
  TextEditingController UserNametextEditingController = new TextEditingController();
  Database database=new Database();
  String confirmVal;
  final formKey = GlobalKey<FormState>();
  bool loading =false;
  static String dbUser;
  static String dbEmail;

 ToSignup(){
   if(formKey.currentState.validate())
   {
      Map<String, String> userMap ={
        "UserName":UserNametextEditingController.text,
        "email":EmailEditingController.text,
      };
      HelperFunctons.SaveUserEmail(EmailEditingController.text);
      HelperFunctons.SaveUserName(UserNametextEditingController.text);
      comparisor();
      setState(() {
        loading=true;
      });
      authonticationMethod.SignUpWithEmailAndPassword(EmailEditingController.text, PasswordEditingController.text).then((val){
        if(check()){
            database.UploadUserInfo(userMap);
            HelperFunctons.SaveUserLogin(true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ChatRoom(),
        ));
        }
       else{
            setState(() {
            loading=false;
          });
         print('Erro with Email and Use name');
         loginErro(context);
         }
      });
   }
 }

 bool check(){
   if(dbUser==null && dbEmail==null){
     return true;
   }
   else{
    return false;
   }
 }
 void comparisor(){
      
      database.getUserByUserName(UserNametextEditingController.text).then((val)async{
        QuerySnapshot user=await val;
        dbUser=user.documents[0].data["UserName"].toString();
        print( user.documents[0].data["UserName"].toString());
      });
      database.getUserByUserEmail(EmailEditingController.text).then((val)async{
        QuerySnapshot email= await val; 
        dbEmail = email.documents[0].data["email"].toString();
        print( email.documents[0].data["email"].toString());
      });
 }
loginErro(BuildContext context){
        return showDialog(context: context,builder: (context){
          return AlertDialog(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
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
                      Text('That you entred email or password alrady using please check the Email or enter another Email to contuniue Sign up process'),
                    ],
                  ),
                ),
              ),
              );
            });
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15) ,
          //height: MediaQuery.of(context).size.height-50 ,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24) ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 200,
                    width:200 ,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("asset/images/signupBackground.png"),
                    ),
                  ),
              ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                          height: 67,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              style: blackTextstyle(),
                              decoration: InputDecoration(
                                      labelText: "User Name",
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: ""
                                    ),
                              controller: UserNametextEditingController,
                              validator: (val){
                                return val.isEmpty|| val.length<4 ? "Invalid User name": null;
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 2,),
                      Container(
                        height: 67,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              style: blackTextstyle(),
                              decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: ""
                                    ),
                              controller: EmailEditingController,
                              validator: (val){
                                      RegExp regExp = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false, multiLine: false,);
                                      return regExp.hasMatch(val) ? null : "Please Enter Valid Email";
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                      Container(
                        height: 67,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              style: blackTextstyle(),
                               decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: ""
                                    ),
                              controller: PasswordEditingController,
                              validator: (val){
                                confirmVal=val;
                                return val.isEmpty|| val.length<8 ? "Invalid Password": null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                      Container(
                        height: 67,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              style: blackTextstyle(),
                               decoration: InputDecoration(
                                      labelText: "Comfirm",
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      helperText: ""
                                    ),
                              validator: (val){
                                return (val==confirmVal|| val.length<8) ? null:"Password not matching with that you entered";
                              },
                              obscureText: true,
                            ),
                          ),
                        ),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: ()
                  {
                    ToSignup();
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
                    child: Text("Create",style: simpleTextstyle(),),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already an user? ",style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text("SignIn",style: TextStyle(
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
      ),
    );
  }
}
