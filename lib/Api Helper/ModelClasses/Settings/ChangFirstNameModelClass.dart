import 'dart:convert';
/// StatusCode : 6000
/// data : "first_name Successfully Updated"

ChangFirstNameModelClass changFirstNameModelClassFromJson(String str) => ChangFirstNameModelClass.fromJson(json.decode(str));
String changFirstNameModelClassToJson(ChangFirstNameModelClass data) => json.encode(data.toJson());
class ChangFirstNameModelClass {
  ChangFirstNameModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangFirstNameModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangFirstNameModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangFirstNameModelClass(  statusCode: statusCode ?? _statusCode,
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