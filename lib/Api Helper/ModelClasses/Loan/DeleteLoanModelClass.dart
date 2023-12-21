import 'dart:convert';
/// StatusCode : 6000
/// data : "Loans Successfully Deleted"

DeleteLoanModelClass deleteLoanModelClassFromJson(String str) => DeleteLoanModelClass.fromJson(json.decode(str));
String deleteLoanModelClassToJson(DeleteLoanModelClass data) => json.encode(data.toJson());
class DeleteLoanModelClass {
  DeleteLoanModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteLoanModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DeleteLoanModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteLoanModelClass(  statusCode: statusCode ?? _statusCode,
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