import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/extension/String_ext.dart';
import 'package:foodorder/model/UserResponse.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../Core/Animation/Fade_Animation.dart';

class AddUser extends StatefulWidget {
  User? user;

  AddUser({super.key, this.user});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool isPassword = true;
  bool confirmIsPassword = true;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    if (widget.user != null) {
      fnameController.text = widget.user!.name!;
      lnameController.text = widget.user!.lname!;
      phoneController.text = widget.user!.contact!;
      emailController.text = widget.user!.email!;
      // addressController.text = widget.user!.password!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: FadeAnimation(
              delay: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAnimation(
                            delay: 1,
                            child: Text(
                              widget.user == null ? "Add User" : 'Update User',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Text(
                              "please fill in the form to continue",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorRes.grey,
                                  letterSpacing: 0.5,
                                  fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            controller: fnameController,
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                  color: deaible,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border))),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return 'can not be empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            controller: lnameController,
                            decoration: InputDecoration(
                                hintText: 'Last Name',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                  color: deaible,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border))),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return 'can not be empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: deaible,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border))),
                            validator: (value) {
                              if (value!.isValidEmail()) {
                                return null;
                              } else {
                                return '* invalid email';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            controller: phoneController,
                            decoration: InputDecoration(
                                hintText: 'contact',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: deaible,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border))),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return '* phone is required';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: 'Address',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: deaible,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorRes.border))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => userController.signUpLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: ColorRes.yellow))
                              : FadeAnimation(
                                  delay: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (widget.user == null) {
                                                var param = {
                                                  "Name": fnameController.text
                                                      .toString()
                                                      .trim(),
                                                  "lname": lnameController.text
                                                      .toString()
                                                      .trim(),
                                                  "Email": emailController.text
                                                      .toString()
                                                      .trim(),
                                                  "contact": phoneController
                                                      .text
                                                      .toString()
                                                      .trim(),
                                                  "address": addressController
                                                      .text
                                                      .toString()
                                                      .trim()
                                                };
                                                final value =
                                                    await userController.signUp(
                                                        param, false);
                                                if (value) {
                                                  Get.back();
                                                }
                                              } else {
                                                var param = {
                                                  "id": widget.user!.id,
                                                  "Name": fnameController.text
                                                      .toString()
                                                      .trim(),
                                                  "lname": lnameController.text
                                                      .toString()
                                                      .trim(),
                                                  "Email": emailController.text
                                                      .toString()
                                                      .trim(),
                                                  "contact": phoneController
                                                      .text
                                                      .toString()
                                                      .trim(),
                                                  "address": addressController
                                                      .text
                                                      .toString()
                                                      .trim()
                                                };
                                                final value =
                                                    await userController.signUp(
                                                        param, true);
                                                if (value) {
                                                  Get.back(result: true);
                                                }
                                              }
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: ColorRes.yellow,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18.0,
                                                      horizontal: 80),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0))),
                                          child: Text(
                                            widget.user == null
                                                ? "Save"
                                                : 'Update',
                                            style: TextStyle(
                                              color: ColorRes.fontColor,
                                              letterSpacing: 0.5,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ],
                                  ),
                                ))
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
        ),
      ),
    );
  }
}
