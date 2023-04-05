class GrpMemWiseModel {
  int? slnum;
  String? madcid;
  String? madcname;
  String? adcid;
  String? adcname;
  String? kormi;
  String? korminam;
  int? groupid;
  String? sgName;
  int? memberid;
  String? smName;
  double? openam;
  num? scham;
  double? achivam;
  double? regamp;
  double? regfqp;
  double? closam;
  String? sgSex;
  double? mdqty;
  double? depqty;

  GrpMemWiseModel(
      {this.slnum,
      this.madcid,
      this.madcname,
      this.adcid,
      this.adcname,
      this.kormi,
      this.korminam,
      this.groupid,
      this.sgName,
      this.memberid,
      this.smName,
      this.openam,
      this.scham,
      this.achivam,
      this.regamp,
      this.regfqp,
      this.closam,
      this.sgSex,
      this.mdqty,
      this.depqty});

  GrpMemWiseModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    madcid = json['madcid'];
    madcname = json['madcname'];
    adcid = json['adcid'];
    adcname = json['adcname'];
    kormi = json['kormi'];
    korminam = json['korminam'];
    groupid = json['groupid'];
    sgName = json['sg_name'];
    memberid = json['memberid'];
    smName = json['sm_name'];
    openam = json['openam'];
    scham = json['scham'];
    achivam = json['achivam'];
    regamp = json['regamp'];
    regfqp = json['regfqp'];
    closam = json['closam'];
    sgSex = json['sg_sex'];
    mdqty = json['mdqty'];
    depqty = json['depqty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['madcid'] = this.madcid;
    data['madcname'] = this.madcname;
    data['adcid'] = this.adcid;
    data['adcname'] = this.adcname;
    data['kormi'] = this.kormi;
    data['korminam'] = this.korminam;
    data['groupid'] = this.groupid;
    data['sg_name'] = this.sgName;
    data['memberid'] = this.memberid;
    data['sm_name'] = this.smName;
    data['openam'] = this.openam;
    data['scham'] = this.scham;
    data['achivam'] = this.achivam;
    data['regamp'] = this.regamp;
    data['regfqp'] = this.regfqp;
    data['closam'] = this.closam;
    data['sg_sex'] = this.sgSex;
    data['mdqty'] = this.mdqty;
    data['depqty'] = this.depqty;
    return data;
  }
}
