import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/model/MenuResponse.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Animation/Fade_Animation.dart';

class AddMenu extends StatefulWidget {
  Menu? menu;

  AddMenu({super.key, this.menu});

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

  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController descController = TextEditingController();
  final oDateController = TextEditingController();
  final dDateController = TextEditingController();
  String? imagePath;
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    if (widget.menu == null) {
      orderDate = DateTime.now().millisecondsSinceEpoch;
      deliveryDate = DateTime.now().millisecondsSinceEpoch;
      oDateController.text = dateFormat.format(DateTime.now());
      dDateController.text = dateFormat.format(DateTime.now());
    } else {
      DateTime order = dateFormat.parse(widget.menu!.date!);
      orderDate = order.millisecondsSinceEpoch;

      DateTime deliver = dateFormat.parse(widget.menu!.expectedDate!);
      deliveryDate = deliver.millisecondsSinceEpoch;

      oDateController.text = widget.menu!.date!;
      dDateController.text = widget.menu!.expectedDate!;

      productController.text = widget.menu!.prodectName!;
      priceController.text = widget.menu!.price!;
      quantityController.text = widget.menu!.quantity!;
      descController.text = widget.menu!.description!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.menu == null ? 'Add Menu' : 'Edit Menu')),
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
                        widget.menu == null
                            ? "Add Menu Item"
                            : 'Edit Menu Item',
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
                      controller: productController,
                      decoration: InputDecoration(
                          hintText: 'Product Name',
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
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: 'Price',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.attach_money,
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
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      controller: quantityController,
                      decoration: InputDecoration(
                          hintText: 'Quantity',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.production_quantity_limits,
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showPickerDate(context);
                            },
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              enabled: false,
                              controller: oDateController,
                              decoration: InputDecoration(
                                labelText: 'Order Date',
                                helperStyle:
                                    const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.7))),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showDDatePickerDate(context);
                            },
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              enabled: false,
                              controller: dDateController,
                              decoration: InputDecoration(
                                labelText: 'Delivery Date',
                                helperStyle:
                                    const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.7))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                  if (widget.menu == null) {
                                    if (imagePath == null) {
                                      Fluttertoast.showToast(
                                          msg: 'image is required');
                                      return;
                                    }
                                    var productName =
                                        productController.text.toString();
                                    int price = int.parse(
                                        priceController.text.toString());
                                    int quantity = int.parse(
                                        quantityController.text.toString());
                                    var desc = descController.text.toString();
                                    var param = {
                                      "prodect": productName,
                                      "cat_menu": 13,
                                      "price": price.toDouble(),
                                      "date": oDateController.text.toString(),
                                      "expected_date":
                                          dDateController.text.toString(),
                                      "quantity": quantity,
                                      "desc": desc,
                                      "status": 1,
                                      "P_photo": await MultipartFile.fromFile(
                                          imagePath!),
                                    };
                                    var result = await userController.addMenu(
                                        param, false);
                                    if (result) {
                                      Get.back(result: true);
                                    }
                                  } else {
                                    var productName =
                                        productController.text.toString();
                                    int price = int.parse(
                                        priceController.text.toString());
                                    int quantity = int.parse(
                                        quantityController.text.toString());
                                    var desc = descController.text.toString();
                                    var param = {
                                      "id": widget.menu!.id,
                                      "prodect": productName,
                                      "cat_menu": 13,
                                      "price": price.toDouble(),
                                      "date": oDateController.text.toString(),
                                      "expected_date":
                                          dDateController.text.toString(),
                                      "quantity": quantity,
                                      "desc": desc,
                                      "status": 1,
                                    };
                                    if (imagePath != null) {
                                      param.addAll({
                                        "P_photo": await MultipartFile.fromFile(
                                            imagePath!)
                                      });
                                    }
                                    var result = await userController.addMenu(
                                        param, true);
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
                                  widget.menu == null ? "Save" : 'Update',
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

  int orderDate = 0;
  int deliveryDate = 0;

  showPickerDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.fromMillisecondsSinceEpoch(orderDate),
        //get today's date
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      orderDate = pickedDate.millisecondsSinceEpoch;
      oDateController.text = dateFormat.format(
          DateTime.fromMillisecondsSinceEpoch(
              pickedDate.millisecondsSinceEpoch));
      setState(() {});
    }
  }

  showDDatePickerDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.fromMillisecondsSinceEpoch(deliveryDate),
        //get today's date
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      deliveryDate = pickedDate.millisecondsSinceEpoch;
      dDateController.text = dateFormat.format(
          DateTime.fromMillisecondsSinceEpoch(
              pickedDate.millisecondsSinceEpoch));
      setState(() {});
    }
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
