import 'package:foodorder/model/User.dart';

class UserInfo {
  User? user;
  String? error;
  String? message;

  UserInfo({this.user, this.error, this.message});

  UserInfo.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
