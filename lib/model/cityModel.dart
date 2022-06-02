class CityModel {
  int? id;
  String? name;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CityModel(
      {this.id,
        this.name,
        this.provinceId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
