import 'package:flutter/material.dart';
import 'package:foodorder/controller/UserController.dart';
import 'package:foodorder/extension/String_ext.dart';
import 'package:foodorder/screens/Login_Screen.dart';
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

  TextEditingController nameController = TextEditingController();
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
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.network(
                            "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Text(
                            "Create your account",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          controller: nameController,
                          decoration:
                              const InputDecoration(hintText: 'username'),
                          validator: (value) {
                            if (value!.isNotEmpty) {
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
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          controller: emailController,
                          decoration: const InputDecoration(hintText: 'email'),
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
                          decoration:
                              const InputDecoration(hintText: 'contact'),
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
                          decoration:
                              const InputDecoration(hintText: 'address'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: selected == FormData.password
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: isPassword
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
                                onPressed: () =>
                                    setState(() => isPassword = !isPassword),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 16)),
                          obscureText: isPassword,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return '* password is required';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: selected == FormData.password
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
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
                                onPressed: () => setState(() =>
                                    confirmIsPassword = !confirmIsPassword),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 16)),
                          obscureText: confirmIsPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'can not empty';
                            }
                            if (value !=
                                passwordController.text.toString().trim()) {
                              return 'password not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => userController.signUpLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : FadeAnimation(
                                delay: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var param = {
                                          "username": nameController.text
                                              .toString()
                                              .trim(),
                                          "email": emailController.text
                                              .toString()
                                              .trim(),
                                          "password": passwordController.text
                                              .toString()
                                              .trim(),
                                          "contact": phoneController.text
                                              .toString()
                                              .trim(),
                                          "address": addressController.text
                                              .toString()
                                              .trim()
                                        };
                                        final value = await userController.signUp(param);
                                        if(value){
                                          Get.back();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return LoginScreen();
                                                  }));
                                        }

                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2697FF),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0, horizontal: 80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0))),
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
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
                      const Text("If you have an account ",
                          style: TextStyle(
                            color: Colors.grey,
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
                        child: Text("Sing in",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
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
    );
  }
}
