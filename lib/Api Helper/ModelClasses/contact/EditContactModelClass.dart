import 'dart:convert';
/// StatusCode : 6000
/// data : "Updated Acdcount Successfully Updated"

EditContactModelClass editContactModelClassFromJson(String str) => EditContactModelClass.fromJson(json.decode(str));
String editContactModelClassToJson(EditContactModelClass data) => json.encode(data.toJson());
class EditContactModelClass {
  EditContactModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
EditContactModelClass copyWith({  int? statusCode,
  String? data,
}) => EditContactModelClass(  statusCode: statusCode ?? _statusCode,
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