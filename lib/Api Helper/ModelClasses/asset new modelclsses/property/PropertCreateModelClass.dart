import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully added property in asset"

PropertCreateModelClass propertCreateModelClassFromJson(String str) => PropertCreateModelClass.fromJson(json.decode(str));
String propertCreateModelClassToJson(PropertCreateModelClass data) => json.encode(data.toJson());
class PropertCreateModelClass {
  PropertCreateModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  PropertCreateModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
PropertCreateModelClass copyWith({  int? statusCode,
  String? message,
}) => PropertCreateModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
);
  int? get statusCode => _statusCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    return map;
  }

}