class PSSReportModel {
  String? madcid;
  String? madcname;
  String? adcid;
  String? adcname;
  String? kormi;
  String? korminam;
  int? groupid;
  String? sgName;
  String? sgSex;
  int? totmem;
  int? depmem;
  double? openam;
  double? scham;
  double? achivam;
  double? regamp;
  double? regfqp;
  double? closam;
  double? mdqty;
  double? depqty;

  PSSReportModel(
      {this.madcid,
      this.madcname,
      this.adcid,
      this.adcname,
      this.kormi,
      this.korminam,
      this.groupid,
      this.sgName,
      this.sgSex,
      this.totmem,
      this.depmem,
      this.openam,
      this.scham,
      this.achivam,
      this.regamp,
      this.regfqp,
      this.closam,
      this.mdqty,
      this.depqty});

  PSSReportModel.fromJson(Map<String, dynamic> json) {
    madcid = json['madcid'];
    madcname = json['madcname'];
    adcid = json['adcid'];
    adcname = json['adcname'];
    kormi = json['kormi'];
    korminam = json['korminam'];
    groupid = json['groupid'];
    sgName = json['sg_name'];
    sgSex = json['sg_sex'];
    totmem = json['totmem'];
    depmem = json['depmem'];
    openam = json['openam'];
    scham = json['scham'];
    achivam = json['achivam'];
    regamp = json['regamp'];
    regfqp = json['regfqp'];
    closam = json['closam'];
    mdqty = json['mdqty'];
    depqty = json['depqty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['madcid'] = this.madcid;
    data['madcname'] = this.madcname;
    data['adcid'] = this.adcid;
    data['adcname'] = this.adcname;
    data['kormi'] = this.kormi;
    data['korminam'] = this.korminam;
    data['groupid'] = this.groupid;
    data['sg_name'] = this.sgName;
    data['sg_sex'] = this.sgSex;
    data['totmem'] = this.totmem;
    data['depmem'] = this.depmem;
    data['openam'] = this.openam;
    data['scham'] = this.scham;
    data['achivam'] = this.achivam;
    data['regamp'] = this.regamp;
    data['regfqp'] = this.regfqp;
    data['closam'] = this.closam;
    data['mdqty'] = this.mdqty;
    data['depqty'] = this.depqty;
    return data;
  }
}