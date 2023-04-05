class KormiWiseLnDisb {
  String? adcid;
  String? kormi;
  String? lName;
  int? memno;
  double? disbamount;

  KormiWiseLnDisb({this.adcid, this.kormi, this.lName, this.memno, this.disbamount});

  KormiWiseLnDisb.fromJson(Map<String, dynamic> json) {
    adcid = json['adcid'];
    kormi = json['kormi'];
    lName = json['l_name'];
    memno = json['memno'];
    disbamount = json['disbamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adcid'] = this.adcid;
    data['kormi'] = this.kormi;
    data['l_name'] = this.lName;
    data['memno'] = this.memno;
    data['disbamount'] = this.disbamount;
    return data;
  }
}
