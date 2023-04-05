class UnionModel {
  int? slnum;
  String? aThana;
  String? uvcode;
  String? uvname;
  String? uvnamb;
  double? geoLat;
  double? geoLong;

  UnionModel({this.slnum, this.aThana, this.uvcode, this.uvname, this.uvnamb, this.geoLat, this.geoLong});

  UnionModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    aThana = json['a_thana'];
    uvcode = json['uvcode'];
    uvname = json['uvname'];
    uvnamb = json['uvnamb'];
    geoLat = json['geo_lat'];
    geoLong = json['geo_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['a_thana'] = this.aThana;
    data['uvcode'] = this.uvcode;
    data['uvname'] = this.uvname;
    data['uvnamb'] = this.uvnamb;
    data['geo_lat'] = this.geoLat;
    data['geo_long'] = this.geoLong;
    return data;
  }
}
