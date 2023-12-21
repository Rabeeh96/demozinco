import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully Updated Asset"

CreateStockModelClass createStockModelClassFromJson(String str) => CreateStockModelClass.fromJson(json.decode(str));
String createStockModelClassToJson(CreateStockModelClass data) => json.encode(data.toJson());
class CreateStockModelClass {
  CreateStockModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  CreateStockModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
CreateStockModelClass copyWith({  int? statusCode,
  String? message,
}) => CreateStockModelClass(  statusCode: statusCode ?? _statusCode,
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