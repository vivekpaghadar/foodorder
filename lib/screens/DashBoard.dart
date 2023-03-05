import 'package:flutter/material.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:foodorder/screens/CategoryList.dart';
import 'package:foodorder/screens/Login_Screen.dart';
import 'package:foodorder/screens/UserList.dart';
import 'package:foodorder/screens/add_menu.dart';
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
      drawer: drawerWidget(),
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
                              child: ListView.builder(
                                  itemCount:
                                      userController.productResponse.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext c, int index) {
                                    return getItem(
                                        userController.productResponse[index]!);
                                  }),
                            ),
                    ),
                  ],
                )),
    );
  }

  Widget getItem(ProductResponse productResponse) {
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
                      borderRadius: BorderRadius.circular(125),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(125.0),
                    child: Image.network(productResponse.photo!,height: 250,width: 250,fit: BoxFit.cover)/*const Image(
                        image: AssetImage(pizza),
                        height: 250,
                        width: 250,
                        fit: BoxFit.fill)*/,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productResponse.prodectName ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$${productResponse.price ?? ''}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(productResponse.description ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w200, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  drawerWidget() {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 7,
                  shadowColor: Colors.black.withOpacity(0.7),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: const Text("User"),
                      leading: const Icon(Icons.person), //add icon
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                // Get.to(const UserList());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Add User'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.privacy_tip, color: ColorRes.appColor),
                                    ],
                                  ),
                                  minLeadingWidth: 10,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                Get.to(const UserList());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('View User'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.privacy_tip, color: ColorRes.appColor),
                                    ],
                                  ),
                                  minLeadingWidth: 10,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //action on press
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 7,
                  shadowColor: Colors.black.withOpacity(0.7),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: const Text("Menu"),
                      leading: const Icon(Icons.person), //add icon
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                final result = await Get.to(AddMenu());
                                if (result != null) {
                                  if (result) {
                                    if (result != null) {
                                      userController.getProduct();
                                    }
                                  }
                                }
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Add Menu'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.email, color: ColorRes.appColor),
                                    ],
                                  ),
                                  minLeadingWidth: 10,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //action on press
                          },
                        ), // add menu
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 7,
                  shadowColor: Colors.black.withOpacity(0.7),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: const Text("Category"),
                      leading: const Icon(Icons.person), //add icon
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                Get.to(const CategoryList());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Category List'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sticky_note_2, color: ColorRes.appColor),
                                    ],
                                  ),
                                  minLeadingWidth: 10,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //action on press
                          },
                        ), // userList
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
