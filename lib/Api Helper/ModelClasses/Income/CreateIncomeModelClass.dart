import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Created"

CreateIncomeModelClass createIncomeModelClassFromJson(String str) => CreateIncomeModelClass.fromJson(json.decode(str));
String createIncomeModelClassToJson(CreateIncomeModelClass data) => json.encode(data.toJson());
class CreateIncomeModelClass {
  CreateIncomeModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  CreateIncomeModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json['errors'];
  }
  int? _statusCode;
  String? _data;
CreateIncomeModelClass copyWith({  int? statusCode,
  String? data,
}) => CreateIncomeModelClass(  statusCode: statusCode ?? _statusCode,
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