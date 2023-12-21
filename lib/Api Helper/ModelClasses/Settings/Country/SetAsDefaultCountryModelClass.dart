import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

SetAsDefaultCountryModelClass setAsDefaultCountryModelClassFromJson(String str) => SetAsDefaultCountryModelClass.fromJson(json.decode(str));
String setAsDefaultCountryModelClassToJson(SetAsDefaultCountryModelClass data) => json.encode(data.toJson());
class SetAsDefaultCountryModelClass {
  SetAsDefaultCountryModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  SetAsDefaultCountryModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
SetAsDefaultCountryModelClass copyWith({  int? statusCode,
  String? data,
}) => SetAsDefaultCountryModelClass(  statusCode: statusCode ?? _statusCode,
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