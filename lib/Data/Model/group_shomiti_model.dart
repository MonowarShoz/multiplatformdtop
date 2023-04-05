class GroupShomitiModel {
  int? slnum;
  String? adcid;
  double? sgAdcno;
  int? sgGroup;
  int? sgMember;
  String? sgName;
  String? sgSex;
  String? gender;
  double? sgSavper;
  String? sgEffdat;
  double? sgDeposit;
  double? sgWithdra;
  String? sgUpdt;
  String? kormi;
  String? lName;
  String? sgNameE;
  int? meetday;
  String? meetdaynam;
  String? aThana;
  String? aUnion;
  String? uninam;
  String? uvcode;
  String? vilnam;
  int? rowid;

  GroupShomitiModel(
      {this.slnum,
      this.adcid,
      this.sgAdcno,
      this.sgGroup,
      this.sgMember,
      this.sgName,
      this.sgSex,
      this.gender,
      this.sgSavper,
      this.sgEffdat,
      this.sgDeposit,
      this.sgWithdra,
      this.sgUpdt,
      this.kormi,
      this.lName,
      this.sgNameE,
      this.meetday,
      this.meetdaynam,
      this.aThana,
      this.aUnion,
      this.uninam,
      this.uvcode,
      this.vilnam,
      this.rowid});

  GroupShomitiModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    adcid = json['adcid'];
    sgAdcno = json['sg_adcno'];
    sgGroup = json['sg_group'];
    sgMember = json['sg_member'];
    sgName = json['sg_name'];
    sgSex = json['sg_sex'];
    gender = json['gender'];
    sgSavper = json['sg_savper'];
    sgEffdat = json['sg_effdat'];
    sgDeposit = json['sg_deposit'];
    sgWithdra = json['sg_withdra'];
    sgUpdt = json['sg_updt'];
    kormi = json['kormi'];
    lName = json['l_name'];
    sgNameE = json['sg_name_e'];
    meetday = json['meetday'];
    meetdaynam = json['meetdaynam'];
    aThana = json['a_thana'];
    aUnion = json['a_union'];
    uninam = json['uninam'];
    uvcode = json['uvcode'];
    vilnam = json['vilnam'];
    rowid = json['rowid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['adcid'] = this.adcid;
    data['sg_adcno'] = this.sgAdcno;
    data['sg_group'] = this.sgGroup;
    data['sg_member'] = this.sgMember;
    data['sg_name'] = this.sgName;
    data['sg_sex'] = this.sgSex;
    data['gender'] = this.gender;
    data['sg_savper'] = this.sgSavper;
    data['sg_effdat'] = this.sgEffdat;
    data['sg_deposit'] = this.sgDeposit;
    data['sg_withdra'] = this.sgWithdra;
    data['sg_updt'] = this.sgUpdt;
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['sg_name_e'] = this.sgNameE;
    data['meetday'] = this.meetday;
    data['meetdaynam'] = this.meetdaynam;
    data['a_thana'] = this.aThana;
    data['a_union'] = this.aUnion;
    data['uninam'] = this.uninam;
    data['uvcode'] = this.uvcode;
    data['vilnam'] = this.vilnam;
    data['rowid'] = this.rowid;
    return data;
  }
}
