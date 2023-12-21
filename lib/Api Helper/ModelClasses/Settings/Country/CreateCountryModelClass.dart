import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Created"
/// errors : "Country Already exists "

CreateCountryModelClass createCountryModelClassFromJson(String str) => CreateCountryModelClass.fromJson(json.decode(str));
String createCountryModelClassToJson(CreateCountryModelClass data) => json.encode(data.toJson());
class CreateCountryModelClass {
  CreateCountryModelClass({
      int? statusCode, 
      String? data, 
      String? errors,}){
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
}

  CreateCountryModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
    _errors = json['errors'];
  }
  int? _statusCode;
  String? _data;
  String? _errors;
CreateCountryModelClass copyWith({  int? statusCode,
  String? data,
  String? errors,
}) => CreateCountryModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  errors: errors ?? _errors,
);
  int? get statusCode => _statusCode;
  String? get data => _data;
  String? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['data'] = _data;
    map['errors'] = _errors;
    return map;
  }

}