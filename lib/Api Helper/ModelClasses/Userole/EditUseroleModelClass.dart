import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully updated UserRole"
/// user_role_id : 72

EditUseroleModelClass editUseroleModelClassFromJson(String str) => EditUseroleModelClass.fromJson(json.decode(str));
String editUseroleModelClassToJson(EditUseroleModelClass data) => json.encode(data.toJson());
class EditUseroleModelClass {
  EditUseroleModelClass({
      int? statusCode, 
      String? message, 
      int? userRoleId,}){
    _statusCode = statusCode;
    _message = message;
    _userRoleId = userRoleId;
}

  EditUseroleModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _userRoleId = json['user_role_id'];
  }
  int? _statusCode;
  String? _message;
  int? _userRoleId;
EditUseroleModelClass copyWith({  int? statusCode,
  String? message,
  int? userRoleId,
}) => EditUseroleModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  userRoleId: userRoleId ?? _userRoleId,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  int? get userRoleId => _userRoleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    map['user_role_id'] = _userRoleId;
    return map;
  }

}