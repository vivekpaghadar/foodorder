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
  void initState() {
    // TODO: implement initState
    getAllProduct();
    super.initState();
  }

  getAllProduct() {
    userController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dummy Product List')),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'logout',
            onPressed: () {
              userController.userInfo = null;
              Pref.removeToken();
              Get.offAll(LoginScreen());
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {},
        child: Obx(() => userController.productLoading.value
            ? const Center(child: CircularProgressIndicator())
            : userController.products.isEmpty
                ? const Text('empty')
                : ListView.builder(
                    itemCount: userController.products.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext c, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userController.products[index].title ?? ''),
                            Text(userController.products[index].description ??
                                ''),
                          ],
                        ),
                      );
                    })),
      ),
    );
  }
}
