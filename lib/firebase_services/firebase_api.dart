import 'package:firebase_messaging/firebase_messaging.dart';
var message;
Future<void> handleBackgroundMessage(RemoteMessage)async{


  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');

  print('Playload: ${message.data}');
}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications()async {

    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage) ;
  }
}