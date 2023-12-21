import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Created"

ExpenseCreateModelClass expenseCreateModelClassFromJson(String str) => ExpenseCreateModelClass.fromJson(json.decode(str));
String expenseCreateModelClassToJson(ExpenseCreateModelClass data) => json.encode(data.toJson());
class ExpenseCreateModelClass {
  ExpenseCreateModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ExpenseCreateModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ExpenseCreateModelClass copyWith({  int? statusCode,
  String? data,
}) => ExpenseCreateModelClass(  statusCode: statusCode ?? _statusCode,
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