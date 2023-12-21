import 'dart:convert';
/// StatusCode : 6000
/// message : "Password reset successfully"

PasswordResetModelClass passwordResetModelClassFromJson(String str) => PasswordResetModelClass.fromJson(json.decode(str));
String passwordResetModelClassToJson(PasswordResetModelClass data) => json.encode(data.toJson());
class PasswordResetModelClass {
  PasswordResetModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  PasswordResetModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
PasswordResetModelClass copyWith({  int? statusCode,
  String? message,
}) => PasswordResetModelClass(  statusCode: statusCode ?? _statusCode,
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