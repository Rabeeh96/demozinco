import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

ExpenseEditModelClass expenseEditModelClassFromJson(String str) => ExpenseEditModelClass.fromJson(json.decode(str));
String expenseEditModelClassToJson(ExpenseEditModelClass data) => json.encode(data.toJson());
class ExpenseEditModelClass {
  ExpenseEditModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ExpenseEditModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ExpenseEditModelClass copyWith({  int? statusCode,
  String? data,
}) => ExpenseEditModelClass(  statusCode: statusCode ?? _statusCode,
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