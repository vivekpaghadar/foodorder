class CategoryResponse {
  bool? success;
  Data? data;

  CategoryResponse({this.success, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
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
  List<Category>? results;

  Data({this.count, this.next, this.previous, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Category>[];
      json['results'].forEach((v) {
        results!.add(Category.fromJson(v));
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

class Category {
  String? id;
  String? categoryName;
  String? description;
  String? photo;
  String? status;
  String? date;

  Category(
      {this.id,
      this.categoryName,
      this.description,
      this.photo,
      this.status,
      this.date});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['status'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['Description'] = description;
    data['Photo'] = photo;
    data['status'] = status;
    data['Date'] = date;
    return data;
  }
}
