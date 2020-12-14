import 'dart:io';
import 'package:chat/services/Cons.dart';
import 'package:chat/services/Supportivefunction.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class StorangeRepo {
  Database db = new Database();
  String email;
  getUserEmail()async{
    email=await HelperFunctons.getUserEmail();
    print(email);
  }
  FirebaseStorage storage=FirebaseStorage(storageBucket: "gs://chatapp-6c182.appspot.com");
  Future <void> uploadFile(File file)async{
    try{
      String imageLocation = 'User/Profile/pro${Constants.Name}.jpg';
      var storageRef =storage.ref().child(imageLocation);
      var uploadtask = storageRef.putFile(file);
      await uploadtask.onComplete;
      addPathToDBLocation(imageLocation);
    }
    catch(e){
        print(e.toString());
    }
  }
  getImageUrl(String location)async{
    return await Firestore.instance.collection("storage").where("location",isEqualTo: location).getDocuments();
  }
  Future <void> addPathToDBLocation(String text)async{
      try{
          final ref = FirebaseStorage.instance.ref().child(text);
          var imageString = await ref.getDownloadURL();
          await Firestore.instance.collection('storage').document(email).setData({'url':imageString, 'location':text});
          getImageUrl(text);
      }
      catch(e){
        print(e.toString());
      }
  }
}


