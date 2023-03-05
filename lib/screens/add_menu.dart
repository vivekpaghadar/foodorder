import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Animation/Fade_Animation.dart';

enum FormData { name, phone, email, gender, password, confirmPassword }

class AddMenu extends StatefulWidget {
  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  final ImagePicker _picker = ImagePicker();

  FormData? selected;

  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? imagePath;
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Menu')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          "Add Menu Item",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: selected == FormData.email
                                ? enabled
                                : backgroundColor,
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: productController,
                            onTap: () {
                              setState(() {
                                selected = FormData.name;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.title,
                                color: selected == FormData.name
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
                              hintText: 'Product Name',
                              hintStyle: TextStyle(
                                  color: selected == FormData.name
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 16),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.name
                                    ? enabledtxt
                                    : deaible,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: selected == FormData.phone
                                ? enabled
                                : backgroundColor,
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              setState(() {
                                selected = FormData.phone;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.phone_android_rounded,
                                color: selected == FormData.phone
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
                              hintText: 'Price',
                              hintStyle: TextStyle(
                                  color: selected == FormData.phone
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 16),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.phone
                                    ? enabledtxt
                                    : deaible,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: selected == FormData.email
                                ? enabled
                                : backgroundColor,
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: descController,
                            onTap: () {
                              setState(() {
                                selected = FormData.email;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: selected == FormData.email
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
                              hintText: 'desc',
                              hintStyle: TextStyle(
                                  color: selected == FormData.email
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 16),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.email
                                    ? enabledtxt
                                    : deaible,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            pickImageWidget();
                          },
                          child: const Icon(Icons.image,
                              size: 30, color: Colors.blue)),
                      imageCard(),
                      const SizedBox(
                        height: 25,
                      ),
                      Obx(() => userController.addProductLoading.value
                          ? const CircularProgressIndicator()
                          : FadeAnimation(
                              delay: 1,
                              child: TextButton(
                                  onPressed: () async {
                                    if (imagePath == null) {
                                      Fluttertoast.showToast(
                                          msg: 'image is required');
                                      return;
                                    }
                                    var productName =
                                        productController.text.toString();
                                    int price = int.parse(
                                        priceController.text.toString());
                                    var desc = descController.text.toString();
                                    await userController.addProduct(productName,
                                        price.toDouble(), desc, imagePath!);
                                    Get.back(result: true);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF2697FF),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 80),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  child: const Text(
                                    "Add Product",
                                    style: TextStyle(
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
