class AdcModel {
  int? slnum;
  String? madcid;
  String? adcid;
  String? aName;
  String? aNamb;
  String? aNamde;
  String? aNamdb;
  String? aFormed;
  String? aFormedtxt;
  String? aThana;
  String? thname;
  String? distname;
  String? aAddresse;
  String? aAddressb;
  double? aNo;
  String? aRemarks;
  double? geoLat;
  double? geoLong;
  int? rowid;
  String? rowtime;

  AdcModel(
      {this.slnum,
      this.madcid,
      this.adcid,
      this.aName,
      this.aNamb,
      this.aNamde,
      this.aNamdb,
      this.aFormed,
      this.aFormedtxt,
      this.aThana,
      this.thname,
      this.distname,
      this.aAddresse,
      this.aAddressb,
      this.aNo,
      this.aRemarks,
      this.geoLat,
      this.geoLong,
      this.rowid,
      this.rowtime});

  AdcModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    madcid = json['madcid'];
    adcid = json['adcid'];
    aName = json['a_name'];
    aNamb = json['a_namb'];
    aNamde = json['a_namde'];
    aNamdb = json['a_namdb'];
    aFormed = json['a_formed'];
    aFormedtxt = json['a_formedtxt'];
    aThana = json['a_thana'];
    thname = json['thname'];
    distname = json['distname'];
    aAddresse = json['a_addresse'];
    aAddressb = json['a_addressb'];
    aNo = json['a_no'];
    aRemarks = json['a_remarks'];
    geoLat = json['geo_lat'];
    geoLong = json['geo_long'];
    rowid = json['rowid'];
    rowtime = json['rowtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['madcid'] = this.madcid;
    data['adcid'] = this.adcid;
    data['a_name'] = this.aName;
    data['a_namb'] = this.aNamb;
    data['a_namde'] = this.aNamde;
    data['a_namdb'] = this.aNamdb;
    data['a_formed'] = this.aFormed;
    data['a_formedtxt'] = this.aFormedtxt;
    data['a_thana'] = this.aThana;
    data['thname'] = this.thname;
    data['distname'] = this.distname;
    data['a_addresse'] = this.aAddresse;
    data['a_addressb'] = this.aAddressb;
    data['a_no'] = this.aNo;
    data['a_remarks'] = this.aRemarks;
    data['geo_lat'] = this.geoLat;
    data['geo_long'] = this.geoLong;
    data['rowid'] = this.rowid;
    data['rowtime'] = this.rowtime;
    return data;
  }
}
