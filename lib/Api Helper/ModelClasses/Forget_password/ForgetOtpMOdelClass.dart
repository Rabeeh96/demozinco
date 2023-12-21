import 'dart:convert';
/// StatusCode : 6000
/// message : "OTP verified successfully"
/// email : "fayepo9860@royalka.com"
/// user_id : 52

ForgetOtpMOdelClass forgetOtpMOdelClassFromJson(String str) => ForgetOtpMOdelClass.fromJson(json.decode(str));
String forgetOtpMOdelClassToJson(ForgetOtpMOdelClass data) => json.encode(data.toJson());
class ForgetOtpMOdelClass {
  ForgetOtpMOdelClass({
      int? statusCode, 
      String? message, 
      String? email, 
      int? userId,}){
    _statusCode = statusCode;
    _message = message;
    _email = email;
    _userId = userId;
}

  ForgetOtpMOdelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _email = json['email'];
    _userId = json['user_id'];
  }
  int? _statusCode;
  String? _message;
  String? _email;
  int? _userId;
ForgetOtpMOdelClass copyWith({  int? statusCode,
  String? message,
  String? email,
  int? userId,
}) => ForgetOtpMOdelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  email: email ?? _email,
  userId: userId ?? _userId,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  String? get email => _email;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    map['email'] = _email;
    map['user_id'] = _userId;
    return map;
  }

}