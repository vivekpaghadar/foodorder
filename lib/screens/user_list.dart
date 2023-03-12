import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/UserResponse.dart';
import 'package:foodorder/screens/add_user.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class UserList extends StatefulWidget {
  bool onlyAdminList;

  UserList({Key? key, required this.onlyAdminList}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserController userController = Get.put(UserController());
  List<User?> searchList = [];
  bool isSearch = false;

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  getAllProduct() {
    userController.getUserList(widget.onlyAdminList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyAdminList ? 'User Admin View' : 'User View'),
      ),
      body: Obx(() => userController.addProductLoading.value
          ? const Center(child: CircularProgressIndicator())
          : userController.userList.isEmpty
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
                                  for (var product in userController.userList) {
                                    if (product!.name!
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
                                  userController
                                      .getUserList(widget.onlyAdminList);
                                });
                              },
                              child: ListView.builder(
                                  itemCount: searchList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext c, int index) {
                                    return itemView(searchList[index]!);
                                  }),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  userController
                                      .getUserList(widget.onlyAdminList);
                                });
                              },
                              child: GetBuilder<UserController>(
                                  builder: (userController) {
                                return ListView.builder(
                                    itemCount: userController.userList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext c, int index) {
                                      return itemView(
                                          userController.userList[index]!);
                                    });
                              }),
                            ),
                    ),
                  ],
                )),
    );
  }

  Widget itemView(User user) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.7),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                        child: Icon(Icons.person, color: ColorRes.appColor)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.name!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: Colors.grey,
                        width: 2,
                        height: 20,
                      ),
                    ),
                    Text(
                      user.email!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: Colors.grey,
                        width: 2,
                        height: 20,
                      ),
                    ),
                    Text(
                      user.contact!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Container(
                    //     color: Colors.grey,
                    //     width: 2,
                    //     height: 20,
                    //   ),
                    // ),
                    // Text(
                    //   user.address!,
                    //   style: const TextStyle(fontWeight: FontWeight.w500),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Container(
                    //     color: Colors.grey,
                    //     width: 2,
                    //     height: 20,
                    //   ),
                    // ),
                    // Text(
                    //   user.status!,
                    //   style: const TextStyle(fontWeight: FontWeight.w500),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: Colors.grey,
                        width: 2,
                        height: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await Get.to(AddUser(user: user));
                        if (result != null) {
                          userController.getUserList(widget.onlyAdminList);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child: Icon(Icons.edit, color: ColorRes.appColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: Colors.grey,
                        width: 2,
                        height: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showMyDialog(user);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child:
                                Icon(Icons.delete, color: ColorRes.appColor)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _showMyDialog(User user) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete User'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure you want to delete this user?'),
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
                await userController.removeUser(user);
                PopupDialog.hideDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
