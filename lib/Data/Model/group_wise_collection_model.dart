class GrpAndMembWiseColModel {
  String? adcid;
  String? kormi;
  String? lName;
  int? groupid;
  String? sgName;
  int? memberid;
  String? smName;
  double? psscoll;
  double? esspcoll;
  double? pssscoll;
  double? dbsscoll;
  double? plsscoll;
  double? realamt;

  GrpAndMembWiseColModel(
      {this.adcid,
      this.kormi,
      this.lName,
      this.groupid,
      this.sgName,
      this.memberid,
      this.smName,
      this.psscoll,
      this.esspcoll,
      this.pssscoll,
      this.dbsscoll,
      this.plsscoll,
      this.realamt});

  GrpAndMembWiseColModel.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    groupid = json['groupid'];
    sgName = json['sg_name'];
    memberid = json['memberid'];
    smName = json['sm_name'];
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
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['groupid'] = this.groupid;
    data['sg_name'] = this.sgName;
    data['memberid'] = this.memberid;
    data['sm_name'] = this.smName;
    data['psscoll'] = this.psscoll;
    data['esspcoll'] = this.esspcoll;
    data['pssscoll'] = this.pssscoll;
    data['dbsscoll'] = this.dbsscoll;
    data['plsscoll'] = this.plsscoll;
    data['realamt'] = this.realamt;
    return data;
  }
}