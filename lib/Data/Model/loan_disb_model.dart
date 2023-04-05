class LoanDisbModel {
  String? adcid;
  String? kormi;
  String? lName;
  int? sgGroup;
  String? sgName;
  int? smMember;
  String? smName;
  String? pNo;
  String? disbdate;
  double? disbamount;
  String? startdate;

  LoanDisbModel(
      {this.adcid,
      this.kormi,
      this.lName,
      this.sgGroup,
      this.sgName,
      this.smMember,
      this.smName,
      this.pNo,
      this.disbdate,
      this.disbamount,
      this.startdate});

  LoanDisbModel.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    sgGroup = json['sg_group'];
    sgName = json['sg_name'];
    smMember = json['sm_member'];
    smName = json['sm_name'];
    pNo = json['p_no'];
    disbdate = json['disbdate'];
    disbamount = json['disbamount'];
    startdate = json['startdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['sg_group'] = this.sgGroup;
    data['sg_name'] = this.sgName;
    data['sm_member'] = this.smMember;
    data['sm_name'] = this.smName;
    data['p_no'] = this.pNo;
    data['disbdate'] = this.disbdate;
    data['disbamount'] = this.disbamount;
    data['startdate'] = this.startdate;
    return data;
  }
}
