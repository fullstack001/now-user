class CategoriesModel {
  CategoriesModel({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CategoriesModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  var id;
  dynamic categoryId;
  var name;
  dynamic image;
  var type;
  var status;
  var createdAt;
  var updatedAt;
  var selected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['image'] = image;
    map['type'] = type;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
