class KwLoanRlzSum {
  String? adcid;
  String? kormi;
  String? lName;
  int? prjno;
  int? memno;
  double? sprn;
  double? ssch;
  double? stotal;
  double? aprn;
  double? asch;
  double? atreal;
  double? tvar1;
  double? otrval1;
  double? otrper1;

  KwLoanRlzSum(
      {this.adcid,
      this.kormi,
      this.lName,
      this.prjno,
      this.memno,
      this.sprn,
      this.ssch,
      this.stotal,
      this.aprn,
      this.asch,
      this.atreal,
      this.tvar1,
      this.otrval1,
      this.otrper1});

  KwLoanRlzSum.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    prjno = json['prjno'];
    memno = json['memno'];
    sprn = json['sprn'];
    ssch = json['ssch'];
    stotal = json['stotal'];
    aprn = json['aprn'];
    asch = json['asch'];
    atreal = json['atreal'];
    tvar1 = json['tvar1'];
    otrval1 = json['otrval1'];
    otrper1 = json['otrper1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['prjno'] = this.prjno;
    data['memno'] = this.memno;
    data['sprn'] = this.sprn;
    data['ssch'] = this.ssch;
    data['stotal'] = this.stotal;
    data['aprn'] = this.aprn;
    data['asch'] = this.asch;
    data['atreal'] = this.atreal;
    data['tvar1'] = this.tvar1;
    data['otrval1'] = this.otrval1;
    data['otrper1'] = this.otrper1;
    return data;
  }
}
