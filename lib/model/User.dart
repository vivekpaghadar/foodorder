class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? contact;
  String? address;
  String? status;
  String? wpAdmin;
  String? date;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.contact,
        this.address,
        this.status,
        this.wpAdmin,
        this.date});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    contact = json['contact'];
    address = json['address'];
    status = json['status'];
    wpAdmin = json['wp_admin'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['Email'] = email;
    data['Password'] = password;
    data['contact'] = contact;
    data['address'] = address;
    data['status'] = status;
    data['wp_admin'] = wpAdmin;
    data['Date'] = date;
    return data;
  }
}