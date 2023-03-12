import 'package:flutter/material.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/MenuResponse.dart';
import 'package:foodorder/screens/add_category.dart';
import 'package:foodorder/screens/add_menu.dart';
import 'package:foodorder/screens/add_recipe.dart';
import 'package:foodorder/screens/add_user.dart';
import 'package:foodorder/screens/category_list.dart';
import 'package:foodorder/screens/login_screen.dart';
import 'package:foodorder/screens/menu_list.dart';
import 'package:foodorder/screens/recipe_list.dart';
import 'package:foodorder/screens/user_list.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  UserController userController = Get.put(UserController());
  List<Menu?> searchList = [];
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    //getAllProduct();
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
        title: const Center(child: Text('Dashboard')),
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
      body: const Center(child: Text('Admin DashBoard')),
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
                    child: Image.network(menu.photo!,
                        fit: BoxFit
                            .cover) /*const Image(
                        image: AssetImage(pizza),
                        height: 250,
                        width: 250,
                        fit: BoxFit.fill)*/
                    ,
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
                    onTap: () {
                      Get.to(AddMenu());
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
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
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
                                Get.to(AddUser());
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
                                      Icon(Icons.privacy_tip,
                                          color: ColorRes.appColor),
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
                                Get.to(UserList(onlyAdminList: false));
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
                                      Icon(Icons.privacy_tip,
                                          color: ColorRes.appColor),
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
                        // admin userList
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                Get.to(UserList(onlyAdminList: true));
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('View Admin User'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.privacy_tip,
                                          color: ColorRes.appColor),
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
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
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
                                      Icon(Icons.email,
                                          color: ColorRes.appColor),
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
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                final result = await Get.to(const MenuList());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('View Menu'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.email,
                                          color: ColorRes.appColor),
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
                        ), // menu list
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
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
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
                                Get.to(AddCategory());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Add Category'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sticky_note_2,
                                          color: ColorRes.appColor),
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
                                      Icon(Icons.sticky_note_2,
                                          color: ColorRes.appColor),
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
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: const Text("Recipe"),
                      leading: const Icon(Icons.person), //add icon
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                Get.to(AddRecipe());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Add Recipe'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sticky_note_2,
                                          color: ColorRes.appColor),
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
                                Get.to(const RecipeList());
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: const Text('Recipe List'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sticky_note_2,
                                          color: ColorRes.appColor),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
