import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/extension/String_ext.dart';
import 'package:foodorder/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../Core/Animation/Fade_Animation.dart';

enum FormData { name, phone, email, gender, password, confirmPassword }

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool isPassword = true;
  bool confirmIsPassword = true;

  FormData? selected;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              "Create new account",
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
                                                "contact": phoneController.text
                                                    .toString()
                                                    .trim(),
                                                "address": addressController
                                                    .text
                                                    .toString()
                                                    .trim()
                                              };
                                              final value = await userController
                                                  .signUp(param, false);
                                              if (value) {
                                                Get.back();
                                                Get.snackbar("Success",
                                                    "Register Successfully");
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginScreen();
                                                }));
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
                                            "Sign Up",
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

                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("If you have an account? ",
                            style: TextStyle(
                              color: ColorRes.fontColor,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10),
                            child: Text("Sing in",
                                style: TextStyle(
                                    color: Colors.blue.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                    fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
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
