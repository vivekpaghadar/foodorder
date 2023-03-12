import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/CategoryController.dart';
import 'package:foodorder/model/RecipeResponse.dart';
import 'package:foodorder/screens/add_recipe.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  CategoryController categoryController = Get.put(CategoryController());
  List<Recipe?> searchList = [];
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
    categoryController.getRecipeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
      ),
      body: Obx(() => categoryController.loading.value
          ? const Center(child: CircularProgressIndicator())
          : categoryController.recipeList.isEmpty
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
                                      in categoryController.recipeList) {
                                    if (product!.recipesName!
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
                                  categoryController.getRecipeList();
                                });
                              },
                              child: GetBuilder<CategoryController>(
                                  builder: (categoryController) {
                                return ListView.builder(
                                    itemCount:
                                        categoryController.recipeList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return itemView(categoryController
                                          .recipeList[index]!);
                                    });
                              }),
                            ),
                    ),
                  ],
                )),
    );
  }

  Widget itemView(Recipe recipe) {
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
                recipe.recipesName!,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
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
                      imageUrl: recipe.photo!,
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
            ],
          ),
          trailing: InkWell(
            onTap: () {
              _showMyDialog(recipe);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: double.infinity,
                  child: Icon(Icons.delete, color: ColorRes.appColor)),
            ),
          ),
          subtitle: Text(recipe.description!),
          leading: InkWell(
            onTap: () async {
              final result = await Get.to(AddRecipe(recipe: recipe));
              if (result != null) {
                categoryController.getRecipeList();
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

  Future<void> _showMyDialog(Recipe recipe) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Recipe'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure you want to delete this recipe?'),
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
                await categoryController.removeRecipe(recipe);
                PopupDialog.hideDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
