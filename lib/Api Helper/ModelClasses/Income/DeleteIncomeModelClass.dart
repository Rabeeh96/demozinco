import 'dart:convert';
/// StatusCode : 6000
/// data : "Finances Successfully Deleted"

DeleteIncomeModelClass deleteIncomeModelClassFromJson(String str) => DeleteIncomeModelClass.fromJson(json.decode(str));
String deleteIncomeModelClassToJson(DeleteIncomeModelClass data) => json.encode(data.toJson());
class DeleteIncomeModelClass {
  DeleteIncomeModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteIncomeModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DeleteIncomeModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteIncomeModelClass(  statusCode: statusCode ?? _statusCode,
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