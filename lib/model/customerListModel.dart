class CustomerListModel {
  int? id;
  String? custName;
  double lat=1;
  double long=1;
  int? verified;
  String? custAddress;
  String? salemanName;
  String? custPrimNb;
  double distance=1;

  CustomerListModel(
      {this.id,
        this.custName,
        required this.lat,
        required this.long,
        this.verified,
        this.custAddress,
        this.salemanName,
        this.custPrimNb,
        required this.distance
      });

  CustomerListModel.fromJson(Map<String, dynamic> json,double distance) {
    id = json['id'];
    custName = json['cust_name'];
    lat = double.parse(json['lat'].toString()=="null"?1.toString():json['lat'].toString());
    long = double.parse(json['long'].toString()=="null"?1.toString():json['long'].toString());
    verified = json['verified'];
    custAddress = json['cust_address'];
    salemanName = json['saleman_name'];
    custPrimNb = json['cust_prim_nb'];
    this.distance = distance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cust_name'] = this.custName;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['verified'] = this.verified;
    data['cust_address'] = this.custAddress;
    data['saleman_name'] = this.salemanName;
    data['cust_prim_nb'] = this.custPrimNb;
    return data;
  }
}
