import 'dart:convert';
/// StatusCode : 6000
/// data : "Transaction Successfully Deleted"

DeleteTransactionContactModelClass deleteTransactionContactModelClassFromJson(String str) => DeleteTransactionContactModelClass.fromJson(json.decode(str));
String deleteTransactionContactModelClassToJson(DeleteTransactionContactModelClass data) => json.encode(data.toJson());
class DeleteTransactionContactModelClass {
  DeleteTransactionContactModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteTransactionContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DeleteTransactionContactModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteTransactionContactModelClass(  statusCode: statusCode ?? _statusCode,
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