class SubBranchDetails {
  String? adcid;
  String? auth;
  String? stafid;
  String? autrmrk;
  String? lName;
  int? rowid;

  SubBranchDetails({this.adcid, this.auth, this.stafid, this.autrmrk, this.lName, this.rowid});

  SubBranchDetails.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    auth = json['auth'];
    stafid = json['stafid'];
    autrmrk = json['autrmrk'];
    lName = json['l_name'];
    rowid = json['rowid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['auth'] = this.auth;
    data['stafid'] = this.stafid;
    data['autrmrk'] = this.autrmrk;
    data['l_name'] = this.lName;
    data['rowid'] = this.rowid;
    return data;
  }
}
