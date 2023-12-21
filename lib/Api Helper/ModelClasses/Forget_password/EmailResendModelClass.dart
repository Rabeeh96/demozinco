import 'dart:convert';
/// StatusCode : 6000
/// message : "Email sended successfully"

EmailResendModelClass emailResendModelClassFromJson(String str) => EmailResendModelClass.fromJson(json.decode(str));
String emailResendModelClassToJson(EmailResendModelClass data) => json.encode(data.toJson());
class EmailResendModelClass {
  EmailResendModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  EmailResendModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
EmailResendModelClass copyWith({  int? statusCode,
  String? message,
}) => EmailResendModelClass(  statusCode: statusCode ?? _statusCode,
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