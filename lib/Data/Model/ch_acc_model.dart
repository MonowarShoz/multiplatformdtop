class ChofAccModel {
  String? accid;
  String? acctitle;
  String? acctype;
  String? accrmrks;
  int? accorder;
  String? accactive;

  ChofAccModel({this.accid, this.acctitle, this.acctype, this.accrmrks, this.accorder, this.accactive});

  ChofAccModel.fromJson(Map<String, dynamic> json) {
    accid = json['accid'];
    acctitle = json['acctitle'];
    acctype = json['acctype'];
    accrmrks = json['accrmrks'];
    accorder = json['accorder'];
    accactive = json['accactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accid'] = this.accid;
    data['acctitle'] = this.acctitle;
    data['acctype'] = this.acctype;
    data['accrmrks'] = this.accrmrks;
    data['accorder'] = this.accorder;
    data['accactive'] = this.accactive;
    return data;
  }
}
