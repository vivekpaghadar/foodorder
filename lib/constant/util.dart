import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String pizza = 'asset/images/pizza.jpeg';
const String google = 'asset/images/google.png';
const String cart = 'asset/images/cart.png';
DateFormat dateFormat = DateFormat('yyyy-MM-dd');

class ColorRes {
  static Color appColor = Colors.blue.shade200;
  static Color fontColor = const Color(0XFF242132);
  static Color border = const Color(0XffE4E4E4);
  static Color grey = const Color(0Xff6E6B72);
  static Color background = const Color(0XFFEFEFEF);
  static Color yellow = const Color(0XFFFFC532);
}

class PopupDialog {
  static showLoaderDialog(context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("  Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hideDialog(context) {
    Navigator.of(context).pop();
  }
}
