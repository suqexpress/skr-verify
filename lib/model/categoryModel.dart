class CategoryModel {
  int? id;
  String? catName;

  CategoryModel({this.id, this.catName});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_name'] = this.catName;
    return data;
  }
}
