class KwLoanRlzDetails {
  String? adcid;
  String? kormi;
  String? lName;
  int? groupid;
  String? sgName;
  int? memberid;
  String? smName;
  int? dropout;
  String? pNo;
  num? sprn;
  num? ssch;
  num? aprn;
  num? asch;
  num? stotal;
  num? aprn1;
  num? asch1;
  num? atreal;
  num? tvar1;
  num? otrval1;
  double? otrper1;

  KwLoanRlzDetails(
      {this.adcid,
      this.kormi,
      this.lName,
      this.groupid,
      this.sgName,
      this.memberid,
      this.smName,
      this.dropout,
      this.pNo,
      this.sprn,
      this.ssch,
      this.aprn,
      this.asch,
      this.stotal,
      this.aprn1,
      this.asch1,
      this.atreal,
      this.tvar1,
      this.otrval1,
      this.otrper1});

  KwLoanRlzDetails.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    groupid = json['groupid'];
    sgName = json['sg_name'];
    memberid = json['memberid'];
    smName = json['sm_name'];
    dropout = json['dropout'];
    pNo = json['p_no'];
    sprn = json['sprn'];
    ssch = json['ssch'];
    aprn = json['aprn'];
    asch = json['asch'];
    stotal = json['stotal'];
    aprn1 = json['aprn1'];
    asch1 = json['asch1'];
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
    data['groupid'] = this.groupid;
    data['sg_name'] = this.sgName;
    data['memberid'] = this.memberid;
    data['sm_name'] = this.smName;
    data['dropout'] = this.dropout;
    data['p_no'] = this.pNo;
    data['sprn'] = this.sprn;
    data['ssch'] = this.ssch;
    data['aprn'] = this.aprn;
    data['asch'] = this.asch;
    data['stotal'] = this.stotal;
    data['aprn1'] = this.aprn1;
    data['asch1'] = this.asch1;
    data['atreal'] = this.atreal;
    data['tvar1'] = this.tvar1;
    data['otrval1'] = this.otrval1;
    data['otrper1'] = this.otrper1;
    return data;
  }
}
