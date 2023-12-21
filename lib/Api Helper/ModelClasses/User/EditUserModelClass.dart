import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully updated User"
/// User_id : 4

EditUserModelClass editUserModelClassFromJson(String str) => EditUserModelClass.fromJson(json.decode(str));
String editUserModelClassToJson(EditUserModelClass data) => json.encode(data.toJson());
class EditUserModelClass {
  EditUserModelClass({
      int? statusCode, 
      String? message, 
      int? userId,}){
    _statusCode = statusCode;
    _message = message;
    _userId = userId;
}

  EditUserModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _userId = json['User_id'];
  }
  int? _statusCode;
  String? _message;
  int? _userId;
EditUserModelClass copyWith({  int? statusCode,
  String? message,
  int? userId,
}) => EditUserModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  userId: userId ?? _userId,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    map['User_id'] = _userId;
    return map;
  }

}