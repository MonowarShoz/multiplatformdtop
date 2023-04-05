class ChofAccTypeModel {
  String? typeid;
  String? typedesc;
  String? acctype;

  ChofAccTypeModel({this.typeid, this.typedesc, this.acctype});

  ChofAccTypeModel.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typedesc = json['typedesc'];
    acctype = json['acctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typedesc'] = this.typedesc;
    data['acctype'] = this.acctype;
    return data;
  }
}
