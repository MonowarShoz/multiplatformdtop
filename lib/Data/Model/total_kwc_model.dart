class TotalkwCModel {
  String? adcid;
  num? psscoll;
  num? esspcoll;
  num? pssscoll;
  num? dbsscoll;
  num? plsscoll;
  num? realamt;

  TotalkwCModel({this.adcid, this.psscoll, this.esspcoll, this.pssscoll, this.dbsscoll, this.plsscoll, this.realamt});

  TotalkwCModel.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    psscoll = json['psscoll'];
    esspcoll = json['esspcoll'];
    pssscoll = json['pssscoll'];
    dbsscoll = json['dbsscoll'];
    plsscoll = json['plsscoll'];
    realamt = json['realamt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['psscoll'] = this.psscoll;
    data['esspcoll'] = this.esspcoll;
    data['pssscoll'] = this.pssscoll;
    data['dbsscoll'] = this.dbsscoll;
    data['plsscoll'] = this.plsscoll;
    data['realamt'] = this.realamt;
    return data;
  }
}
