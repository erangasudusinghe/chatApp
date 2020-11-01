import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ImageUrl;
  Future GetImage()async{
    final store =Firestore.instance;
    final picker =ImagePicker();
    PickedFile image;
    await Permission.photos.request();
    var PermissionStatus =await Permission.photos.status;
    if(PermissionStatus.isGranted){
        image = await picker.getImage(source: ImageSource.gallery);
        var file =File(image.path);
        if(image!=null){

        }
        else{
          print("no path recived");
        }
    }
    else{
        print("garnt dinied");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width:double.infinity,
            ),
            Text("data"),
          ],
        ),
      ),
    );
  }
}
