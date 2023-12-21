import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully Updated Asset"

EditStockModelClass editStockModelClassFromJson(String str) => EditStockModelClass.fromJson(json.decode(str));
String editStockModelClassToJson(EditStockModelClass data) => json.encode(data.toJson());
class EditStockModelClass {
  EditStockModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  EditStockModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
EditStockModelClass copyWith({  int? statusCode,
  String? message,
}) => EditStockModelClass(  statusCode: statusCode ?? _statusCode,
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