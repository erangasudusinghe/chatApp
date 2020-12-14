import 'dart:async';
import 'package:chat/services/Cons.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class InternetConnection {
  // ignore: cancel_subscriptions
  StreamSubscription<DataConnectionStatus> listener;
  checkConnection(BuildContext context) async{
  listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status){
      case DataConnectionStatus.connected:
        Constants.isconnected=true;
        break;
      case DataConnectionStatus.disconnected:
        Constants.isconnected=false;
        break;
    }
  });
  return await DataConnectionChecker().connectionStatus;
}
}