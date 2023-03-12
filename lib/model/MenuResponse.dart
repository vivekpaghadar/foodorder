class MenuResponse {
  bool? success;
  Data? data;

  MenuResponse({this.success, this.data});

  MenuResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic previous;
  List<Menu>? results;

  Data({this.count, this.next, this.previous, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Menu>[];
      json['results'].forEach((v) {
        results!.add(Menu.fromJson(v));
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

class Menu {
  String? id;
  String? prodectName;
  String? catMenu;
  String? price;
  String? date;
  String? expectedDate;
  String? quantity;
  String? description;
  String? photo;
  String? status;

  Menu(
      {this.id,
      this.prodectName,
      this.catMenu,
      this.price,
      this.date,
      this.expectedDate,
      this.quantity,
      this.description,
      this.photo,
      this.status});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodectName = json['Prodect_name'];
    catMenu = json['cat_menu'];
    price = json['Price'];
    date = json['date'];
    expectedDate = json['expected_date'];
    quantity = json['quantity'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Prodect_name'] = prodectName;
    data['cat_menu'] = catMenu;
    data['Price'] = price;
    data['date'] = date;
    data['expected_date'] = expectedDate;
    data['quantity'] = quantity;
    data['Description'] = description;
    data['Photo'] = photo;
    data['status'] = status;
    return data;
  }
}
