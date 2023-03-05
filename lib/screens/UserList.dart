import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/User.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class UserList extends StatefulWidget {
  bool onlyAdminList;
  UserList({Key? key,required this.onlyAdminList}) : super(key: key);

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
        title: Text(
            widget.onlyAdminList ? 'User Admin View' : 'User View'),
      ),
      body: Obx(() => userController.addProductLoading.value
          ? const Center(child: CircularProgressIndicator())
          : userController.userResponse.isEmpty
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
                                      in userController.userResponse) {
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
                                  userController.getUserList(widget.onlyAdminList);
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
                                  userController.getUserList(widget.onlyAdminList);
                                });
                              },
                              child: ListView.builder(
                                  itemCount: userController.userResponse.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext c, int index) {
                                    return itemView(
                                        userController.userResponse[index]!);
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
            child: ListTile(
              title: Text(
                user.name!,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(user.email!),
              leading: SizedBox(
                  height: double.infinity,
                  child: Icon(Icons.person, color: ColorRes.appColor)),
              // trailing: PopupMenuButton(
              //   onSelected: (value) {
              //     // onMenuItemSelected(value as int, file, isPDF);
              //   },
              //   padding: EdgeInsets.zero,
              //   offset: Offset(0.0, appbarHeight),
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
              //   ),
              //   itemBuilder: (ctx) => [
              //     _buildPopupMenuItem(
              //         'Open', Icons.open_in_new_rounded, Options.open.index),
              //     _buildPopupMenuItem(
              //         'Share', Icons.share, Options.share.index),
              //     _buildPopupMenuItem(
              //         'Rename',
              //         Icons.drive_file_rename_outline_sharp,
              //         Options.rename.index),
              //     if (!isPDF)
              //       _buildPopupMenuItem(
              //           'Duplicate', Icons.copy_all, Options.edit.index),
              //     _buildPopupMenuItem(
              //         'Delete', Icons.delete, Options.delete.index),
              //   ],
              // ),
              minLeadingWidth: 10,
            ),
          )),
    );
  }
}
