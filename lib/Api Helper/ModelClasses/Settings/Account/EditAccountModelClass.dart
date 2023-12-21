import 'dart:convert';
/// StatusCode : 6000
/// data : "Updated Account Successfully Updated"

EditAccountModelClass editAccountModelClassFromJson(String str) => EditAccountModelClass.fromJson(json.decode(str));
String editAccountModelClassToJson(EditAccountModelClass data) => json.encode(data.toJson());
class EditAccountModelClass {
  EditAccountModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditAccountModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["errors"];
  }
  int? _statusCode;
  String? _data;
EditAccountModelClass copyWith({  int? statusCode,
  String? data,
}) => EditAccountModelClass(  statusCode: statusCode ?? _statusCode,
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