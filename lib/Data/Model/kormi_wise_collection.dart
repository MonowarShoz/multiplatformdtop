class KormiWiseCollection {
  String? adcid;
  String? kormi;
  String? lName;
  double? psscoll;
  double? esspcoll;
  double? pssscoll;
  double? dbsscoll;
  double? plsscoll;
  double? realamt;
  double? totamt;

  KormiWiseCollection(
      {this.adcid,
      this.kormi,
      this.lName,
      this.psscoll,
      this.esspcoll,
      this.pssscoll,
      this.dbsscoll,
      this.plsscoll,
      this.realamt,
      this.totamt});

  KormiWiseCollection.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    psscoll = json['psscoll'];
    esspcoll = json['esspcoll'];
    pssscoll = json['pssscoll'];
    dbsscoll = json['dbsscoll'];
    plsscoll = json['plsscoll'];
    realamt = json['realamt'];
    totamt = json['totamt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['psscoll'] = this.psscoll;
    data['esspcoll'] = this.esspcoll;
    data['pssscoll'] = this.pssscoll;
    data['dbsscoll'] = this.dbsscoll;
    data['plsscoll'] = this.plsscoll;
    data['realamt'] = this.realamt;
    data['totamt'] = this.totamt;
    return data;
  }
}
