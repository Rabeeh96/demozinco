import 'dart:convert';
/// StatusCode : 6000
/// data : "teest Successfully Created"
/// errors : "Accounts with this account name already exist "

CreateAccountModelClass createAccountModelClassFromJson(String str) => CreateAccountModelClass.fromJson(json.decode(str));
String createAccountModelClassToJson(CreateAccountModelClass data) => json.encode(data.toJson());
class CreateAccountModelClass {
  CreateAccountModelClass({
      int? statusCode, 
      String? data, 
      String? errors,}){
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
}

  CreateAccountModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
    _errors = json['errors'];
  }
  int? _statusCode;
  String? _data;
  String? _errors;
CreateAccountModelClass copyWith({  int? statusCode,
  String? data,
  String? errors,
}) => CreateAccountModelClass(  statusCode: statusCode ?? _statusCode,
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