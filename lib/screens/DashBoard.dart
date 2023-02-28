import 'package:flutter/material.dart';
import 'package:foodorder/Feature/LoginScreen/Login_Screen.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  UserController userController = Get.put(UserController());
  List<ProductResponse?> searchList = [];
  bool isSearch = false;

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
        title: const Center(child: Text('Product List')),
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
      body: Obx(() => userController.productLoading.value
          ? const Center(child: CircularProgressIndicator())
          : userController.productResponse.isEmpty
              ? const Text('empty')
              : Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            cursorColor: Colors.grey,
                            onChanged: (text) {
                              searchList.clear();
                              if (text.isEmpty) {
                                isSearch = false;
                                setState(() {});
                                return;
                              }
                              isSearch = true;
                              for (var product
                                  in userController.productResponse) {
                                if (product!.prodectName!
                                    .toLowerCase()
                                    .contains(text.toLowerCase())) {
                                  searchList.add(product);
                                }
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: 18,
                                  child: Image.asset('asset/images/search.png'),
                                )),
                          ),
                        ),
                        // Container(
                        //     margin: const EdgeInsets.only(left: 10),
                        //     padding: const EdgeInsets.all(15),
                        //     decoration: BoxDecoration(
                        //         color: Theme.of(context).primaryColor,
                        //         borderRadius: BorderRadius.circular(15)),
                        //     width: 25,
                        //     child: Image.asset('assets/icons/filter.png')),
                      ],
                    ),
                    Expanded(
                      child: isSearch
                          ? ListView.builder(
                              itemCount: searchList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext c, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Image(image: AssetImage(pizza)),
                                      Text(
                                          searchList[index]?.prodectName ?? ''),
                                      Text(
                                          searchList[index]?.description ?? ''),
                                    ],
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: userController.productResponse.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext c, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Image(image: AssetImage(pizza)),
                                      Text(userController.productResponse[index]
                                              ?.prodectName ??
                                          ''),
                                      Text(userController.productResponse[index]
                                              ?.description ??
                                          ''),
                                    ],
                                  ),
                                );
                              }),
                    ),
                  ],
                )),
    );
  }
}
