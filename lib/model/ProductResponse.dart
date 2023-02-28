class ProductResponse {
  String? id;
  String? prodectName;
  String? price;
  String? description;
  String? photo;
  String? status;
  String? date;

  ProductResponse(
      {this.id,
        this.prodectName,
        this.price,
        this.description,
        this.photo,
        this.status,
        this.date});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodectName = json['Prodect_name'];
    price = json['Price'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['status'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Prodect_name'] = prodectName;
    data['Price'] = price;
    data['Description'] = description;
    data['Photo'] = photo;
    data['status'] = status;
    data['Date'] = date;
    return data;
  }
}
