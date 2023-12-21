import 'dart:convert';
/// StatusCode : 6000
/// message : "Password Updated Successfully"

ChangePasswordModelClass changePasswordModelClassFromJson(String str) => ChangePasswordModelClass.fromJson(json.decode(str));
String changePasswordModelClassToJson(ChangePasswordModelClass data) => json.encode(data.toJson());
class ChangePasswordModelClass {
  ChangePasswordModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  ChangePasswordModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
ChangePasswordModelClass copyWith({  int? statusCode,
  String? message,
}) => ChangePasswordModelClass(  statusCode: statusCode ?? _statusCode,
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