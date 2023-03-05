import 'package:flutter/material.dart';
import 'package:foodorder/screens/Login_Screen.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/screens/DashBoard.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.init();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: go(context),
    );
  }

  go(context) {
    if (Pref.getToken() != null) {
      return const DashBoard();
    } else {
      return LoginScreen();
    }
  }
}
