import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully deleted property in asset"

DeletePropertyModelClass deletePropertyModelClassFromJson(String str) => DeletePropertyModelClass.fromJson(json.decode(str));
String deletePropertyModelClassToJson(DeletePropertyModelClass data) => json.encode(data.toJson());
class DeletePropertyModelClass {
  DeletePropertyModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  DeletePropertyModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
DeletePropertyModelClass copyWith({  int? statusCode,
  String? message,
}) => DeletePropertyModelClass(  statusCode: statusCode ?? _statusCode,
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