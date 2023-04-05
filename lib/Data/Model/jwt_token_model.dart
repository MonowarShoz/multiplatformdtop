class JwtTokenInfo {
  bool? istokenstr;
  String? tokenstr;
  String? createtime;
  String? expirytime;
  String? tokenmsg;

  JwtTokenInfo({
    this.istokenstr,
    this.tokenstr,
    this.createtime,
    this.expirytime,
    this.tokenmsg,
  });
  JwtTokenInfo.fromJson(Map<String, dynamic> json) {
    istokenstr = json['istokenstr'];
    tokenstr = json['tokenstr'];
    createtime = json['createtime'];
    expirytime = json['expirytime'];
    tokenmsg = json['tokenmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['istokenstr'] = this.istokenstr;
    data['tokenstr'] = this.tokenstr;
    data['createtime'] = this.createtime;
    data['expirytime'] = this.expirytime;
    data['tokenmsg'] = this.tokenmsg;

    return data;
  }
}
