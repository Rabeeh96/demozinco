import 'dart:convert';
/// StatusCode : 6000
/// message : "AssetMaster Successfully Deleted"

AssetDeleteModelClass assetDeleteModelClassFromJson(String str) => AssetDeleteModelClass.fromJson(json.decode(str));
String assetDeleteModelClassToJson(AssetDeleteModelClass data) => json.encode(data.toJson());
class AssetDeleteModelClass {
  AssetDeleteModelClass({
      int? statusCode, 
      String? message,}){
    _statusCode = statusCode;
    _message = message;
}

  AssetDeleteModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
  }
  int? _statusCode;
  String? _message;
AssetDeleteModelClass copyWith({  int? statusCode,
  String? message,
}) => AssetDeleteModelClass(  statusCode: statusCode ?? _statusCode,
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