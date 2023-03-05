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
