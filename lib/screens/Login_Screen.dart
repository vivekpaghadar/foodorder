import 'package:flutter/material.dart';
import 'package:foodorder/constant/util.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/extension/String_ext.dart';
import 'package:foodorder/screens/DashBoard.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../Core/Animation/Fade_Animation.dart';
import 'SignUp_Screen.dart';

enum FormData {
  email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool confirmIsPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorRes.background,
        elevation: 0,
      ),
      backgroundColor: ColorRes.background,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: const Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontSize: 26),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Text(
                        "please sign in to your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorRes.grey,
                            letterSpacing: 0.5,
                            fontSize: 22),
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
                              borderSide: BorderSide(color: ColorRes.border)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.border)),

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
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: confirmIsPassword,
                      controller: passwordController,

                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: deaible,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorRes.border)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorRes.border)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorRes.border)),
                        suffixIcon: IconButton(
                          icon: confirmIsPassword
                              ? Icon(
                                  Icons.visibility_off,
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                          onPressed: () => setState(
                              () => confirmIsPassword = !confirmIsPassword),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorRes.border)),
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "can't be empty";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() => userController.loading.value
                        ? const CircularProgressIndicator()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await userController.login(
                                        emailController.text.toString().trim(),
                                        passwordController.text
                                            .toString()
                                            .trim());
                                    if (userController.userInfo != null) {
                                      Get.off(const DashBoard());
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: ColorRes.yellow,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0))),
                                child: Expanded(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: ColorRes.fontColor,
                                      letterSpacing: 0.5,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              ),

              //End of Center Card
              //Start of outer card
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Don't have an account?  ",
                      style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 0.5,
                          fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignupScreen();
                      }));
                    },
                    child: Text("Sign up",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
