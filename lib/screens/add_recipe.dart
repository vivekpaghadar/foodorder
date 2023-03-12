import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/CategoryController.dart';
import 'package:foodorder/model/RecipeResponse.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Animation/Fade_Animation.dart';

class AddRecipe extends StatefulWidget {
  Recipe? recipe;

  AddRecipe({super.key, this.recipe});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  final ImagePicker _picker = ImagePicker();

  TextEditingController recipeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String? imagePath;
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    if (widget.recipe != null) {
      recipeController.text = widget.recipe!.recipesName!;
      descController.text = widget.recipe!.description!;
    } else {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.recipe == null ? 'Add Recipe' : 'Edit Recipe')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(40.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Text(
                        widget.recipe == null ? "Add Recipe" : 'Edit Recipe',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            letterSpacing: 0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: recipeController,
                      decoration: InputDecoration(
                          hintText: 'Recipe Name',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.title,
                            color: deaible,
                            size: 20,
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: descController,
                      maxLines: 6,
                      decoration: InputDecoration(
                          hintText: 'description',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.note_alt,
                            color: deaible,
                            size: 20,
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              pickImageWidget();
                            },
                            child: const Icon(Icons.image,
                                size: 30, color: Colors.blue)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    imageCard(),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(() => categoryController.loading.value
                        ? const CircularProgressIndicator()
                        : FadeAnimation(
                            delay: 1,
                            child: TextButton(
                                onPressed: () async {
                                  if (widget.recipe == null) {
                                    if (imagePath == null) {
                                      Fluttertoast.showToast(
                                          msg: 'image is required');
                                      return;
                                    }
                                    var recipeName =
                                        recipeController.text.toString();
                                    var desc = descController.text.toString();
                                    var param = {
                                      "Recipes": recipeName,
                                      "desc": desc,
                                      "status": 1,
                                      "photo": await MultipartFile.fromFile(
                                          imagePath!),
                                    };
                                    var result = await categoryController
                                        .addRecipe(param, false);
                                    if (result) {
                                      Get.back(result: true);
                                    }
                                  } else {
                                    var recipeName =
                                        recipeController.text.toString();
                                    var desc = descController.text.toString();
                                    var param;
                                    if (imagePath == null) {
                                      param = {
                                        "id": widget.recipe!.id,
                                        "Recipes": recipeName,
                                        "desc": desc,
                                        "status": 1,
                                      };
                                    } else {
                                      param = {
                                        "id": widget.recipe!.id,
                                        "Recipes": recipeName,
                                        "desc": desc,
                                        "status": 1,
                                        "photo": await MultipartFile.fromFile(
                                            imagePath!),
                                      };
                                    }

                                    var result = await categoryController
                                        .addRecipe(param, true);
                                    if (result) {
                                      Get.back(result: true);
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF2697FF),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0))),
                                child: Text(
                                  widget.recipe == null
                                      ? "Add Recipe"
                                      : 'Edit Recipe',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )),
                  ],
                ),
              ),
            ),
            //End of Center Card
            //Start of outer card
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  pickImageWidget() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          pickImage(true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt),
                            SizedBox(width: 3),
                            Text('Camera'),
                          ],
                        ),
                      ),
                    )),
                    const VerticalDivider(color: Colors.grey, thickness: 2),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Get.back();
                        pickImage(false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.photo_library,
                          ),
                          SizedBox(width: 3),
                          Text('Gallery'),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          );
        });
  }

  pickImage(bool fromCamera) async {
    if (fromCamera) {
      final result = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (result != null) {
        imagePath = result.path;
      }
    } else {
      final result = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (result != null) {
        imagePath = result.path;
      }
    }
    setState(() {});
  }

  imageCard() {
    return imagePath != null
        ? Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(5, 5))
                        ]),
                    child: Image.file(File(imagePath!), fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          imagePath = null;
                        });
                      },
                      child: const Icon(Icons.remove_circle,
                          color: Colors.redAccent)))
            ],
          )
        : Container();
  }
}
