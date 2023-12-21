import 'dart:convert';
/// StatusCode : 6000
/// data : "email Successfully Updated"

ChangeEmailModelClass changeEmailModelClassFromJson(String str) => ChangeEmailModelClass.fromJson(json.decode(str));
String changeEmailModelClassToJson(ChangeEmailModelClass data) => json.encode(data.toJson());
class ChangeEmailModelClass {
  ChangeEmailModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeEmailModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeEmailModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeEmailModelClass(  statusCode: statusCode ?? _statusCode,
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