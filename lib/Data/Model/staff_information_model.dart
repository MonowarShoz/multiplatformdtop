class StaffInformationModel {
  int? slnum;
  String? stafid;
  String? lName;
  String? lNameB;
  int? lStno;
  String? dsgMain;
  String? dsgBrief;
  String? dsgSub;
  String? deptName;
  String? deptBrief;
  String? deptBname;
  String? divName;
  String? divBrief;
  String? divBname;
  int? lStno1;
  String? lDate;
  String? aDate;
  String? gender;
  String? lSex;
  String? lRelig;
  String? religion;
  double? lLocn;
  int? lMaincode;
  int? lSubcode;
  String? respName;
  String? respDesc;
  String? respNameB;
  String? mrespName;
  String? mrespDesc;
  String? mrespNameB;
  int? lRspcd;
  int? lRspscd;
  int? lDept;
  int? lSubd;
  String? lLeft;
  int? lStat;
  double? lScale;

  StaffInformationModel(
      {this.slnum,
      this.stafid,
      this.lName,
      this.lNameB,
      this.lStno,
      this.dsgMain,
      this.dsgBrief,
      this.dsgSub,
      this.deptName,
      this.deptBrief,
      this.deptBname,
      this.divName,
      this.divBrief,
      this.divBname,
      this.lStno1,
      this.lDate,
      this.aDate,
      this.gender,
      this.lSex,
      this.lRelig,
      this.religion,
      this.lLocn,
      this.lMaincode,
      this.lSubcode,
      this.respName,
      this.respDesc,
      this.respNameB,
      this.mrespName,
      this.mrespDesc,
      this.mrespNameB,
      this.lRspcd,
      this.lRspscd,
      this.lDept,
      this.lSubd,
      this.lLeft,
      this.lStat,
      this.lScale});

  StaffInformationModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    stafid = json['stafid'];
    lName = json['l_name'];
    lNameB = json['l_name_b'];
    lStno = json['l_stno'];
    dsgMain = json['dsg_main'];
    dsgBrief = json['dsg_brief'];
    dsgSub = json['dsg_sub'];
    deptName = json['dept_name'];
    deptBrief = json['dept_brief'];
    deptBname = json['dept_bname'];
    divName = json['div_name'];
    divBrief = json['div_brief'];
    divBname = json['div_bname'];
    lStno1 = json['l_stno1'];
    lDate = json['l_date'];
    aDate = json['a_date'];
    gender = json['gender'];
    lSex = json['l_sex'];
    lRelig = json['l_relig'];
    religion = json['religion'];
    lLocn = json['l_locn'];
    lMaincode = json['l_maincode'];
    lSubcode = json['l_subcode'];
    respName = json['resp_name'];
    respDesc = json['resp_desc'];
    respNameB = json['resp_name_b'];
    mrespName = json['mresp_name'];
    mrespDesc = json['mresp_desc'];
    mrespNameB = json['mresp_name_b'];
    lRspcd = json['l_rspcd'];
    lRspscd = json['l_rspscd'];
    lDept = json['l_dept'];
    lSubd = json['l_subd'];
    lLeft = json['l_left'];
    lStat = json['l_stat'];
    lScale = json['l_scale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['stafid'] = this.stafid;
    data['l_name'] = this.lName;
    data['l_name_b'] = this.lNameB;
    data['l_stno'] = this.lStno;
    data['dsg_main'] = this.dsgMain;
    data['dsg_brief'] = this.dsgBrief;
    data['dsg_sub'] = this.dsgSub;
    data['dept_name'] = this.deptName;
    data['dept_brief'] = this.deptBrief;
    data['dept_bname'] = this.deptBname;
    data['div_name'] = this.divName;
    data['div_brief'] = this.divBrief;
    data['div_bname'] = this.divBname;
    data['l_stno1'] = this.lStno1;
    data['l_date'] = this.lDate;
    data['a_date'] = this.aDate;
    data['gender'] = this.gender;
    data['l_sex'] = this.lSex;
    data['l_relig'] = this.lRelig;
    data['religion'] = this.religion;
    data['l_locn'] = this.lLocn;
    data['l_maincode'] = this.lMaincode;
    data['l_subcode'] = this.lSubcode;
    data['resp_name'] = this.respName;
    data['resp_desc'] = this.respDesc;
    data['resp_name_b'] = this.respNameB;
    data['mresp_name'] = this.mrespName;
    data['mresp_desc'] = this.mrespDesc;
    data['mresp_name_b'] = this.mrespNameB;
    data['l_rspcd'] = this.lRspcd;
    data['l_rspscd'] = this.lRspscd;
    data['l_dept'] = this.lDept;
    data['l_subd'] = this.lSubd;
    data['l_left'] = this.lLeft;
    data['l_stat'] = this.lStat;
    data['l_scale'] = this.lScale;
    return data;
  }
}
