import 'dart:convert';
/// StatusCode : 6000
/// data : "photo Successfully Updated"

ChangeProfilePhotoModelClass changeProfilePhotoModelClassFromJson(String str) => ChangeProfilePhotoModelClass.fromJson(json.decode(str));
String changeProfilePhotoModelClassToJson(ChangeProfilePhotoModelClass data) => json.encode(data.toJson());
class ChangeProfilePhotoModelClass {
  ChangeProfilePhotoModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeProfilePhotoModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeProfilePhotoModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeProfilePhotoModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['data'] = _data;
    return map;
  }

}