import 'dart:convert';
/// StatusCode : 6000
/// data : "is_interest Successfully Updated"

ChangeIsIntrestModelClass changeIsIntrestModelClassFromJson(String str) => ChangeIsIntrestModelClass.fromJson(json.decode(str));
String changeIsIntrestModelClassToJson(ChangeIsIntrestModelClass data) => json.encode(data.toJson());
class ChangeIsIntrestModelClass {
  ChangeIsIntrestModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeIsIntrestModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeIsIntrestModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeIsIntrestModelClass(  statusCode: statusCode ?? _statusCode,
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