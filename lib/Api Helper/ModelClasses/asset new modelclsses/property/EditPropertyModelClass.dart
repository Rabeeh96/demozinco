import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully edited property in asset"

EditPropertyModelClass editPropertyModelClassFromJson(String str) => EditPropertyModelClass.fromJson(json.decode(str));
String editPropertyModelClassToJson(EditPropertyModelClass data) => json.encode(data.toJson());
class EditPropertyModelClass {
  EditPropertyModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  EditPropertyModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
EditPropertyModelClass copyWith({  int? statusCode,
  String? message,
}) => EditPropertyModelClass(  statusCode: statusCode ?? _statusCode,
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