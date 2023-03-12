class UserResponse {
  bool? success;
  Data? data;

  UserResponse({this.success, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? count;
  String? next;
  Null? previous;
  List<User>? results;

  Data({this.count, this.next, this.previous, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <User>[];
      json['results'].forEach((v) {
        results!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? lname;
  String? email;
  String? password;
  String? contact;
  String? wpAdmin;
  String? date;

  User(
      {this.id,
      this.name,
      this.lname,
      this.email,
      this.password,
      this.contact,
      this.wpAdmin,
      this.date});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    lname = json['lname'];
    email = json['Email'];
    password = json['Password'];
    contact = json['contact'];
    wpAdmin = json['wp_admin'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['lname'] = lname;
    data['Email'] = email;
    data['Password'] = password;
    data['contact'] = contact;
    data['wp_admin'] = wpAdmin;
    data['Date'] = date;
    return data;
  }
}
