class BranchWisePssModel {
  String? madcid;
  String? madcname;
  String? adcid;
  String? adcname;
  String? kormi;
  String? korminam;
  int? totgroup;
  int? depgroup;
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

  BranchWisePssModel(
      {this.madcid,
      this.madcname,
      this.adcid,
      this.adcname,
      this.kormi,
      this.korminam,
      this.totgroup,
      this.depgroup,
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

  BranchWisePssModel.fromJson(Map<String, dynamic> json) {
    madcid = json['madcid'];
    madcname = json['madcname'];
    adcid = json['adcid'];
    adcname = json['adcname'];
    kormi = json['kormi'];
    korminam = json['korminam'];
    totgroup = json['totgroup'];
    depgroup = json['depgroup'];
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
    data['totgroup'] = this.totgroup;
    data['depgroup'] = this.depgroup;
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
