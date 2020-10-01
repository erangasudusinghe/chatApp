import 'package:chat/View/chatRoom.dart';
import 'package:chat/Widgets/Widget.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/athontication.dart';
import 'package:chat/services/database.dart';
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
  final formKey = GlobalKey<FormState>();
  bool loading =false;

 ToSignup(){
   if(formKey.currentState.validate())
   {
      Map<String, String> userMap ={
        "UserName":UserNametextEditingController.text,
        "email":EmailEditingController.text,
      };
      HelperFunctons.SaveUserEmail(EmailEditingController.text);
      HelperFunctons.SaveUserName(UserNametextEditingController.text);
      setState(() {
        loading=true;
      });
      authonticationMethod.SignUpWithEmailAndPassword(EmailEditingController.text, PasswordEditingController.text).then((val){
        database.UploadUserInfo(userMap);
        HelperFunctons.SaveUserLogin(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ChatRoom(),
        ));
      });
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMain(context),
      body: loading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50 ,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24) ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: simpleTextstyle(),
                        decoration: InputDecorationTextField("User Name"),
                        controller: UserNametextEditingController,
                        validator: (val){
                          return val.isEmpty|| val.length<4 ? "Invalid User name": null;
                        },
                      ),
                      TextFormField(
                        style: simpleTextstyle(),
                        decoration: InputDecorationTextField("Email"),
                        controller: EmailEditingController,
                        validator: (val){
                                RegExp regExp = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false, multiLine: false,);
                                return regExp.hasMatch(val) ? null : "Please Enter Valid Email";
                        },
                      ),
                      TextFormField(
                        style: simpleTextstyle(),
                        decoration: InputDecorationTextField("Password"),
                        controller: PasswordEditingController,
                        validator: (val){
                          return val.isEmpty|| val.length<4 ? "Invalid Password": null;
                        },
                        obscureText: true,
                      ),
                      TextFormField(
                        style: simpleTextstyle(),
                        decoration: InputDecorationTextField("Comfirm Password"),
                        validator: (val){
                          return val.isEmpty|| val.length<4 ? "Password not matching with that you entered": null;
                        },
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: ()
                  {
                    ToSignup();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient:LinearGradient(
                        colors:[
                          const Color(0xff00ff00),
                          const Color(0xff008866),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text("Create",style: simpleTextstyle(),),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient:LinearGradient(
                      colors:[
                        const Color(0xffffffff),
                        const Color(0xfffffff8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Sign in With Google",style: TextStyle(
                      color: Colors.black
                  ),),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already an user? ",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text("SignIn",style: TextStyle(
                          color: Colors.white,
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
