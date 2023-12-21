import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Created"

LoanCreateModelClass loanCreateModelClassFromJson(String str) => LoanCreateModelClass.fromJson(json.decode(str));
String loanCreateModelClassToJson(LoanCreateModelClass data) => json.encode(data.toJson());
class LoanCreateModelClass {
  LoanCreateModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  LoanCreateModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["errors"];
  }
  int? _statusCode;
  String? _data;
LoanCreateModelClass copyWith({  int? statusCode,
  String? data,
}) => LoanCreateModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['data'] = _data;
    return map;
  }

}