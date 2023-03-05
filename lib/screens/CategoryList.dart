import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/CategoryController.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/Category.dart';
import 'package:foodorder/model/User.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoryController categoryController = Get.put(CategoryController());
  List<Category?> searchList = [];
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    getAllProduct();
    super.initState();
  }

  getAllProduct() {
    categoryController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: Obx(() => categoryController.loading.value
          ? const Center(child: CircularProgressIndicator())
          : categoryController.categoryList.isEmpty
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
                        in categoryController.categoryList) {
                          if (product!.categoryName!
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
                ? ListView.builder(
                    itemCount: searchList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext c, int index) {
                      return itemView(searchList[index]!);
                    })
                : RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                    const Duration(seconds: 1), () {
                  categoryController.getCategoryList();
                });
              },
              child: ListView.builder(
                  itemCount: categoryController.categoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return itemView(
                        categoryController.categoryList[index]!);
                  }),
            ),
          ),
        ],
      )),
    );
  }

  Widget itemView(Category category) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: GestureDetector(
          onTap: () {

          },
          child: Card(
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.7),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            child: ListTile(
              title: Column(
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
                        child: Image.network(category.photo!,height: 250,width: 250,fit: BoxFit.cover)/*const Image(
                        image: AssetImage(pizza),
                        height: 250,
                        width: 250,
                        fit: BoxFit.fill)*/,
                      ),
                    ),
                  ),
                  Text(
                    category.categoryName!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              subtitle: Text(category.description!),
              leading: SizedBox(
                  height: double.infinity,
                  child: Icon(Icons.category, color: ColorRes.appColor)),
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
