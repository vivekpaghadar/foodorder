import 'package:flutter/material.dart';
import 'package:foodorder/Feature/LoginScreen/Login_Screen.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          userController.userInfo = null;
          Pref.removeToken();
          Get.offAll(LoginScreen());
        },
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('logout'),
          ),
        ),
      ),
    );
  }
}
