import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/MenuResponse.dart';
import 'package:foodorder/screens/add_menu.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  UserController userController = Get.put(UserController());
  List<Menu?> searchList = [];
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
        title: const Text('Product List'),
      ),
      body: Obx(() => userController.productLoading.value
          ? const Center(child: CircularProgressIndicator())
          : userController.menuList.isEmpty
              ? const Text('empty')
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 7,
                        shadowColor: Colors.black.withOpacity(0.7),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        child: Row(
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
                                  for (var product in userController.menuList) {
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
                                      child: Image.asset(
                                          'asset/images/search.png'),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: isSearch
                          ? RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  userController.getProduct();
                                });
                              },
                              child: ListView.builder(
                                  itemCount: searchList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext c, int index) {
                                    return getItem(searchList[index]!);
                                  }),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  userController.getProduct();
                                });
                              },
                              child: GetBuilder<UserController>(
                                  builder: (userController) {
                                return ListView.builder(
                                    itemCount: userController.menuList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext c, int index) {
                                      return getItem(
                                          userController.menuList[index]!);
                                    });
                              }),
                            ),
                    ),
                  ],
                )),
    );
  }

  Widget getItem(Menu menu) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.7),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  elevation: 7,
                  shadowColor: Colors.black.withOpacity(0.7),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: menu.photo!,
                      placeholder: (co, url) {
                        return SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.grey, child: Container(),
                            // child: const Text(
                            //   'Shimmer',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontSize: 40.0,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menu.prodectName ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${menu.price ?? ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Image.asset(
                  //     cart,
                  //     height: 40,
                  //     width: 40,
                  //   ),
                  // ),
                  InkWell(
                    onTap: () async {
                      final result = await Get.to(AddMenu(menu: menu));
                      if (result != null) {
                        userController.getProduct();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.edit, size: 30),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showMyDialog(menu);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete, size: 30),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(productResponse.description ?? '',
              //       style: const TextStyle(
              //           fontWeight: FontWeight.w200, fontSize: 20)),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(Menu menu) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Menu'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure you want to delete this Menu?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: const Text('DELETE'),
              onPressed: () async {
                Navigator.of(ctx).pop();
                PopupDialog.showLoaderDialog(context);
                await userController.removeMenu(menu);
                PopupDialog.hideDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
