import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully Deleted"

DeleteUserModelClass deleteUserModelClassFromJson(String str) => DeleteUserModelClass.fromJson(json.decode(str));
String deleteUserModelClassToJson(DeleteUserModelClass data) => json.encode(data.toJson());
class DeleteUserModelClass {
  DeleteUserModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  DeleteUserModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
DeleteUserModelClass copyWith({  int? statusCode,
  String? message,
}) => DeleteUserModelClass(  statusCode: statusCode ?? _statusCode,
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