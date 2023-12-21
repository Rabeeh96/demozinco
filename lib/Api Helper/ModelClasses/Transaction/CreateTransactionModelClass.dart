import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Created"

CreateTransactionModelClass createTransactionModelClassFromJson(String str) => CreateTransactionModelClass.fromJson(json.decode(str));
String createTransactionModelClassToJson(CreateTransactionModelClass data) => json.encode(data.toJson());
class CreateTransactionModelClass {
  CreateTransactionModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  CreateTransactionModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
CreateTransactionModelClass copyWith({  int? statusCode,
  String? data,
}) => CreateTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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