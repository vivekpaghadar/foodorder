class RecipeResponse {
  bool? success;
  Data? data;

  RecipeResponse({this.success, this.data});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
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
  List<Recipe>? results;

  Data({this.count, this.next, this.previous, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Recipe>[];
      json['results'].forEach((v) {
        results!.add(Recipe.fromJson(v));
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

class Recipe {
  String? id;
  String? recipesName;
  String? description;
  String? photo;
  String? status;
  String? date;

  Recipe(
      {this.id,
      this.recipesName,
      this.description,
      this.photo,
      this.status,
      this.date});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipesName = json['recipes_name'];
    description = json['description'];
    photo = json['photo'];
    status = json['status'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['recipes_name'] = recipesName;
    data['description'] = description;
    data['photo'] = photo;
    data['status'] = status;
    data['Date'] = date;
    return data;
  }
}
