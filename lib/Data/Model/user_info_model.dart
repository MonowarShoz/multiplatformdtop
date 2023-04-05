class UserInfoModel {
  String? stafid;
  String? userid;
  String? pwrmrk;
  String? lName;
  String? lNameB;
  String? paswrd;
  String? perdesc;

  UserInfoModel({this.stafid, this.userid, this.pwrmrk, this.lName, this.lNameB, this.paswrd, this.perdesc});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    stafid = json['stafid'];
    userid = json['userid'];
    pwrmrk = json['pwrmrk'];
    lName = json['l_name'];
    lNameB = json['l_name_b'];
    paswrd = json['paswrd'];
    perdesc = json['perdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stafid'] = this.stafid;
    data['userid'] = this.userid;
    data['pwrmrk'] = this.pwrmrk;
    data['l_name'] = this.lName;
    data['l_name_b'] = this.lNameB;
    data['paswrd'] = this.paswrd;
    data['perdesc'] = this.perdesc;
    return data;
  }
}
