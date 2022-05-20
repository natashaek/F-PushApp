import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //  print('onBackground Handler ${message.messageId}');
    print(message.data);

    final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
    //  _messageStream.add(message.notification?.body ?? 'No title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    print(message.data);

    final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
    //_messageStream.add(message.notification?.body ?? 'No title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //  print('onMessageOpenApp Handler ${message.messageId}');
    print(message.data);

    final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
    //_messageStream.add(message.notification?.body ?? 'No title');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
