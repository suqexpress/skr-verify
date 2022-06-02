class MarketModel {
  int? id;
  String? name;
  int? areaId;
  int? udCd;
  String? ucName;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  MarketModel(
      {this.id,
        this.name,
        this.areaId,
        this.udCd,
        this.ucName,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  MarketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaId = json['area_id'];
    udCd = json['ud_cd'];
    ucName = json['uc_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['area_id'] = this.areaId;
    data['ud_cd'] = this.udCd;
    data['uc_name'] = this.ucName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
