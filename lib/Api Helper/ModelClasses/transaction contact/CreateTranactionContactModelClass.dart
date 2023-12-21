import 'dart:convert';
/// StatusCode : 6000
/// data : "3 Successfully Created"

CreateTranactionContactModelClass createTranactionContactModelClassFromJson(String str) => CreateTranactionContactModelClass.fromJson(json.decode(str));
String createTranactionContactModelClassToJson(CreateTranactionContactModelClass data) => json.encode(data.toJson());
class CreateTranactionContactModelClass {
  CreateTranactionContactModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  CreateTranactionContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
CreateTranactionContactModelClass copyWith({  int? statusCode,
  String? data,
}) => CreateTranactionContactModelClass(  statusCode: statusCode ?? _statusCode,
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