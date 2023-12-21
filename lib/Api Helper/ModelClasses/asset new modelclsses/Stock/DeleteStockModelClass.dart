import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully deleted stock"

DeleteStockModelClass deleteStockModelClassFromJson(String str) => DeleteStockModelClass.fromJson(json.decode(str));
String deleteStockModelClassToJson(DeleteStockModelClass data) => json.encode(data.toJson());
class DeleteStockModelClass {
  DeleteStockModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  DeleteStockModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
DeleteStockModelClass copyWith({ int? statusCode,
  String? message,
}) => DeleteStockModelClass(  statusCode: statusCode ?? _statusCode,
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