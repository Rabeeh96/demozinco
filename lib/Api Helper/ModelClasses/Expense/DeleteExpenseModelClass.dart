import 'dart:convert';
/// StatusCode : 6000
/// data : "Finances Successfully Deleted"

DeleteExpenseModelClass deleteExpenseModelClassFromJson(String str) => DeleteExpenseModelClass.fromJson(json.decode(str));
String deleteExpenseModelClassToJson(DeleteExpenseModelClass data) => json.encode(data.toJson());
class DeleteExpenseModelClass {
  DeleteExpenseModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteExpenseModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DeleteExpenseModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteExpenseModelClass(  statusCode: statusCode ?? _statusCode,
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