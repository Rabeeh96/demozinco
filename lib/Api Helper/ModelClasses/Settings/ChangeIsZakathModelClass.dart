import 'dart:convert';
/// StatusCode : 6000
/// data : "is_zakath Successfully Updated"

ChangeIsZakathModelClass changeIsZakathModelClassFromJson(String str) => ChangeIsZakathModelClass.fromJson(json.decode(str));
String changeIsZakathModelClassToJson(ChangeIsZakathModelClass data) => json.encode(data.toJson());
class ChangeIsZakathModelClass {
  ChangeIsZakathModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeIsZakathModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeIsZakathModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeIsZakathModelClass(  statusCode: statusCode ?? _statusCode,
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