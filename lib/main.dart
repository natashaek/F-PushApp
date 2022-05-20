import 'package:flutter/material.dart';
import 'package:pushapp_n/services/push_notifications_services.dart';
import 'package:pushapp_n/src/pages/home_page.dart';
import 'package:pushapp_n/src/pages/mensaje_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();

    //
    PushNotificationService.messageStream.listen((data) {
      print('MyApp: $data');

      navigatorKey.currentState?.pushNamed('mensaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MensajePage()
      },
    );
  }
}
