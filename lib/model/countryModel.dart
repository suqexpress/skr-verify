class CountryModel {
  int? id;
  String? name;
  String? countryCode;
  String? countryNick;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CountryModel(
      {this.id,
        this.name,
        this.countryCode,
        this.countryNick,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    countryNick = json['country_nick'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['country_nick'] = this.countryNick;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
