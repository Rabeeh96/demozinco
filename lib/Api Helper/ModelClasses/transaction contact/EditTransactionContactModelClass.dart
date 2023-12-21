import 'dart:convert';
/// StatusCode : 6000
/// data : "1 Successfully Updated"

EditTransactionContactModelClass editTransactionContactModelClassFromJson(String str) => EditTransactionContactModelClass.fromJson(json.decode(str));
String editTransactionContactModelClassToJson(EditTransactionContactModelClass data) => json.encode(data.toJson());
class EditTransactionContactModelClass {
  EditTransactionContactModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditTransactionContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
EditTransactionContactModelClass copyWith({  int? statusCode,
  String? data,
}) => EditTransactionContactModelClass(  statusCode: statusCode ?? _statusCode,
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