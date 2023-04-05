class BankInformation {
  String? bankid;
  String? bankname;
  String? bacctitle;
  String? acchead;
  String? accnum;
  String? fpid;
  String? adcid;
  double? balam;
  int? rowid;
  String? rowtime;

  BankInformation(
      {this.bankid,
      this.bankname,
      this.bacctitle,
      this.acchead,
      this.accnum,
      this.fpid,
      this.adcid,
      this.balam,
      this.rowid,
      this.rowtime});

  BankInformation.fromJson(Map<String, dynamic> json) {
    bankid = json['bankid'];
    bankname = json['bankname'];
    bacctitle = json['bacctitle'];
    acchead = json['acchead'];
    accnum = json['accnum'];
    fpid = json['fpid'];
    adcid = json['adcid'];
    balam = json['balam'];
    rowid = json['rowid'];
    rowtime = json['rowtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankid'] = this.bankid;
    data['bankname'] = this.bankname;
    data['bacctitle'] = this.bacctitle;
    data['acchead'] = this.acchead;
    data['accnum'] = this.accnum;
    data['fpid'] = this.fpid;
    data['adcid'] = this.adcid;
    data['balam'] = this.balam;
    data['rowid'] = this.rowid;
    data['rowtime'] = this.rowtime;
    return data;
  }
}
