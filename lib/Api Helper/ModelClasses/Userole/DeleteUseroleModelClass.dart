import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully updated UserRole"
/// user_type_id : 4

DeleteUseroleModelClass deleteUseroleModelClassFromJson(String str) => DeleteUseroleModelClass.fromJson(json.decode(str));
String deleteUseroleModelClassToJson(DeleteUseroleModelClass data) => json.encode(data.toJson());
class DeleteUseroleModelClass {
  DeleteUseroleModelClass({
      int? statusCode, 
      String? message, 
      int? userTypeId,}){
    _statusCode = statusCode;
    _message = message;
    _userTypeId = userTypeId;
}

  DeleteUseroleModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _userTypeId = json['user_type_id'];
  }
  int? _statusCode;
  String? _message;
  int? _userTypeId;
DeleteUseroleModelClass copyWith({  int? statusCode,
  String? message,
  int? userTypeId,
}) => DeleteUseroleModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  userTypeId: userTypeId ?? _userTypeId,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  int? get userTypeId => _userTypeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    map['user_type_id'] = _userTypeId;
    return map;
  }

}