import 'package:chat/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthonticationMethod{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  
  Future SignInWithEmailAndPassword(String email,String Password) async {
    try
    {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: Password);
      FirebaseUser firebaseUser =result.user;
      return _userfromFirebase(firebaseUser);
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  User _userfromFirebase(FirebaseUser user)
  {
    return user != null? User(userId: user.uid): null;
  }
  Future SignUpWithEmailAndPassword(String email,String Password) async {
    try
    {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: Password);
      FirebaseUser firebaseUser =result.user;
      return _userfromFirebase(firebaseUser);
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future resetPassword(String email) async
  {
    try{
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future SignOut()async
  {
    try{
      return await _firebaseAuth.signOut();
    }
    catch(e)
    {
      print(e.toString());
    }
  }

}