class ThanaModel {
  int? slnum;
  String? aThana;
  String? thname;
  String? thnamb;
  String? aDistrict;
  String? distname;
  String? distnamb;
  String? aDivid;
  String? divname;
  String? divnamb;

  ThanaModel(
      {this.slnum,
      this.aThana,
      this.thname,
      this.thnamb,
      this.aDistrict,
      this.distname,
      this.distnamb,
      this.aDivid,
      this.divname,
      this.divnamb});

  ThanaModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    aThana = json['a_thana'];
    thname = json['thname'];
    thnamb = json['thnamb'];
    aDistrict = json['a_district'];
    distname = json['distname'];
    distnamb = json['distnamb'];
    aDivid = json['a_divid'];
    divname = json['divname'];
    divnamb = json['divnamb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['a_thana'] = this.aThana;
    data['thname'] = this.thname;
    data['thnamb'] = this.thnamb;
    data['a_district'] = this.aDistrict;
    data['distname'] = this.distname;
    data['distnamb'] = this.distnamb;
    data['a_divid'] = this.aDivid;
    data['divname'] = this.divname;
    data['divnamb'] = this.divnamb;
    return data;
  }
}
