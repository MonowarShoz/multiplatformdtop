class MemberInfoModel {
  int? slnum;
  String? adcid;
  int? smGroup;
  int? smMember;
  double? smAdcno;
  String? smName;
  double? smOpenbal;
  double? openSav;
  double? openInt;
  String? smOpendat;
  double? with21;
  num? with223;
  num? with2O;
  num? with17;
  num? with126;
  num? with101;
  String? smJoindat;
  String? smLeftdat;
  double? leftreason;
  String? smUpdt;
  double? balance;
  String? bdate;
  String? smNameE;
  String? ocucatid;
  String? eoccupatin;
  String? dob;
  String? education;
  String? eeducation;
  String? smAddress;
  num? villCode;
  num? unionCode;
  String? mStatus;
  String? grpStatus;
  num? dropout;
  num? isresource;
  num? essprate;
  num? fcode;
  num? savrate;
  num? hardcore;
  String? intdesc;
  int? rlfdefault;
  String? essplint;
  num? esspoption;
  num? pssint;
  num? wloan;
  String? memphon;
  String? memnid;
  String? presaddr;
  String? peraddr;
  String? fatnam;
  String? fatphon;
  String? fatnid;
  String? motnam;
  String? motphon;
  String? motnid;
  String? spounam;
  String? spouphon;
  String? spounid;
  String? nominam1;
  String? nominid1;
  String? nomirel1;
  double? nomishr1;
  String? nomirmrk1;
  String? nominam2;
  String? nominid2;
  String? nomirel2;
  double? nomishr2;
  String? nomirmrk2;
  String? nominam3;
  String? nominid3;
  String? nomirel3;
  double? nomishr3;
  String? nomirmrk3;
  String? dwkormi;
  String? apkormi;
  int? rowid;

  MemberInfoModel(
      {this.slnum,
      this.adcid,
      this.smGroup,
      this.smMember,
      this.smAdcno,
      this.smName,
      this.smOpenbal,
      this.openSav,
      this.openInt,
      this.smOpendat,
      this.with21,
      this.with223,
      this.with2O,
      this.with17,
      this.with126,
      this.with101,
      this.smJoindat,
      this.smLeftdat,
      this.leftreason,
      this.smUpdt,
      this.balance,
      this.bdate,
      this.smNameE,
      this.ocucatid,
      this.eoccupatin,
      this.dob,
      this.education,
      this.eeducation,
      this.smAddress,
      this.villCode,
      this.unionCode,
      this.mStatus,
      this.grpStatus,
      this.dropout,
      this.isresource,
      this.essprate,
      this.fcode,
      this.savrate,
      this.hardcore,
      this.intdesc,
      this.rlfdefault,
      this.essplint,
      this.esspoption,
      this.pssint,
      this.wloan,
      this.memphon,
      this.memnid,
      this.presaddr,
      this.peraddr,
      this.fatnam,
      this.fatphon,
      this.fatnid,
      this.motnam,
      this.motphon,
      this.motnid,
      this.spounam,
      this.spouphon,
      this.spounid,
      this.nominam1,
      this.nominid1,
      this.nomirel1,
      this.nomishr1,
      this.nomirmrk1,
      this.nominam2,
      this.nominid2,
      this.nomirel2,
      this.nomishr2,
      this.nomirmrk2,
      this.nominam3,
      this.nominid3,
      this.nomirel3,
      this.nomishr3,
      this.nomirmrk3,
      this.dwkormi,
      this.apkormi,
      this.rowid});

  MemberInfoModel.fromJson(Map<String, dynamic> json) {
    slnum = json['slnum'];
    adcid = json['adcid'];
    smGroup = json['sm_group'];
    smMember = json['sm_member'];
    smAdcno = json['sm_adcno'];
    smName = json['sm_name'];
    smOpenbal = json['sm_openbal'];
    openSav = json['open_sav'];
    openInt = json['open_int'];
    smOpendat = json['sm_opendat'];
    with21 = json['with2_1'];
    with223 = json['with2_23'];
    with2O = json['with2_o'];
    with17 = json['with1_7'];
    with126 = json['with1_26'];
    with101 = json['with1_01'];
    smJoindat = json['sm_joindat'];
    smLeftdat = json['sm_leftdat'];
    leftreason = json['leftreason'];
    smUpdt = json['sm_updt'];
    balance = json['balance'];
    bdate = json['bdate'];
    smNameE = json['sm_name_e'];
    ocucatid = json['ocucatid'];
    eoccupatin = json['eoccupatin'];
    dob = json['dob'];
    education = json['education'];
    eeducation = json['eeducation'];
    smAddress = json['sm_address'];
    villCode = json['vill_code'];
    unionCode = json['union_code'];
    mStatus = json['m_status'];
    grpStatus = json['grp_status'];
    dropout = json['dropout'];
    isresource = json['isresource'];
    essprate = json['essprate'];
    fcode = json['fcode'];
    savrate = json['savrate'];
    hardcore = json['hardcore'];
    intdesc = json['intdesc'];
    rlfdefault = json['rlfdefault'];
    essplint = json['essplint'];
    esspoption = json['esspoption'];
    pssint = json['pssint'];
    wloan = json['wloan'];
    memphon = json['memphon'];
    memnid = json['memnid'];
    presaddr = json['presaddr'];
    peraddr = json['peraddr'];
    fatnam = json['fatnam'];
    fatphon = json['fatphon'];
    fatnid = json['fatnid'];
    motnam = json['motnam'];
    motphon = json['motphon'];
    motnid = json['motnid'];
    spounam = json['spounam'];
    spouphon = json['spouphon'];
    spounid = json['spounid'];
    nominam1 = json['nominam1'];
    nominid1 = json['nominid1'];
    nomirel1 = json['nomirel1'];
    nomishr1 = json['nomishr1'];
    nomirmrk1 = json['nomirmrk1'];
    nominam2 = json['nominam2'];
    nominid2 = json['nominid2'];
    nomirel2 = json['nomirel2'];
    nomishr2 = json['nomishr2'];
    nomirmrk2 = json['nomirmrk2'];
    nominam3 = json['nominam3'];
    nominid3 = json['nominid3'];
    nomirel3 = json['nomirel3'];
    nomishr3 = json['nomishr3'];
    nomirmrk3 = json['nomirmrk3'];
    dwkormi = json['dwkormi'];
    apkormi = json['apkormi'];
    rowid = json['rowid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slnum'] = this.slnum;
    data['adcid'] = this.adcid;
    data['sm_group'] = this.smGroup;
    data['sm_member'] = this.smMember;
    data['sm_adcno'] = this.smAdcno;
    data['sm_name'] = this.smName;
    data['sm_openbal'] = this.smOpenbal;
    data['open_sav'] = this.openSav;
    data['open_int'] = this.openInt;
    data['sm_opendat'] = this.smOpendat;
    data['with2_1'] = this.with21;
    data['with2_23'] = this.with223;
    data['with2_o'] = this.with2O;
    data['with1_7'] = this.with17;
    data['with1_26'] = this.with126;
    data['with1_01'] = this.with101;
    data['sm_joindat'] = this.smJoindat;
    data['sm_leftdat'] = this.smLeftdat;
    data['leftreason'] = this.leftreason;
    data['sm_updt'] = this.smUpdt;
    data['balance'] = this.balance;
    data['bdate'] = this.bdate;
    data['sm_name_e'] = this.smNameE;
    data['ocucatid'] = this.ocucatid;
    data['eoccupatin'] = this.eoccupatin;
    data['dob'] = this.dob;
    data['education'] = this.education;
    data['eeducation'] = this.eeducation;
    data['sm_address'] = this.smAddress;
    data['vill_code'] = this.villCode;
    data['union_code'] = this.unionCode;
    data['m_status'] = this.mStatus;
    data['grp_status'] = this.grpStatus;
    data['dropout'] = this.dropout;
    data['isresource'] = this.isresource;
    data['essprate'] = this.essprate;
    data['fcode'] = this.fcode;
    data['savrate'] = this.savrate;
    data['hardcore'] = this.hardcore;
    data['intdesc'] = this.intdesc;
    data['rlfdefault'] = this.rlfdefault;
    data['essplint'] = this.essplint;
    data['esspoption'] = this.esspoption;
    data['pssint'] = this.pssint;
    data['wloan'] = this.wloan;
    data['memphon'] = this.memphon;
    data['memnid'] = this.memnid;
    data['presaddr'] = this.presaddr;
    data['peraddr'] = this.peraddr;
    data['fatnam'] = this.fatnam;
    data['fatphon'] = this.fatphon;
    data['fatnid'] = this.fatnid;
    data['motnam'] = this.motnam;
    data['motphon'] = this.motphon;
    data['motnid'] = this.motnid;
    data['spounam'] = this.spounam;
    data['spouphon'] = this.spouphon;
    data['spounid'] = this.spounid;
    data['nominam1'] = this.nominam1;
    data['nominid1'] = this.nominid1;
    data['nomirel1'] = this.nomirel1;
    data['nomishr1'] = this.nomishr1;
    data['nomirmrk1'] = this.nomirmrk1;
    data['nominam2'] = this.nominam2;
    data['nominid2'] = this.nominid2;
    data['nomirel2'] = this.nomirel2;
    data['nomishr2'] = this.nomishr2;
    data['nomirmrk2'] = this.nomirmrk2;
    data['nominam3'] = this.nominam3;
    data['nominid3'] = this.nominid3;
    data['nomirel3'] = this.nomirel3;
    data['nomishr3'] = this.nomishr3;
    data['nomirmrk3'] = this.nomirmrk3;
    data['dwkormi'] = this.dwkormi;
    data['apkormi'] = this.apkormi;
    data['rowid'] = this.rowid;
    return data;
  }
}
