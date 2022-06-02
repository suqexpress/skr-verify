class AreaModel {
  int? id;
  String? name;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AreaModel(
      {this.id,
        this.name,
        this.cityId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
