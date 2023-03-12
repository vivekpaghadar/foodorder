import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/CategoryController.dart';
import 'package:foodorder/model/CategoryResponse.dart';
import 'package:foodorder/screens/add_category.dart';
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
  final focusNode = FocusNode();
  bool isSearch = false;

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
                              child: GetBuilder<CategoryController>(
                                  builder: (categoryController) {
                                return ListView.builder(
                                    itemCount:
                                        categoryController.categoryList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return itemView(categoryController
                                          .categoryList[index]!);
                                    });
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
      child: Card(
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.7),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.categoryName!,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: InkWell(
            onTap: () {
              _showMyDialog(category);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: double.infinity,
                  child: Icon(Icons.delete, color: ColorRes.appColor)),
            ),
          ),
          subtitle: Text(category.description!),
          leading: InkWell(
            onTap: () async {
              final result = await Get.to(AddCategory(category: category));
              if (result != null) {
                categoryController.getCategoryList();
              }
            },
            child: SizedBox(
                height: double.infinity,
                child: Icon(Icons.edit, color: ColorRes.appColor)),
          ),
          minLeadingWidth: 10,
        ),
      ),
    );
  }

  Future<void> _showMyDialog(Category category) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure you want to delete this category?'),
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
                await categoryController.removeCategory(category);
                PopupDialog.hideDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
