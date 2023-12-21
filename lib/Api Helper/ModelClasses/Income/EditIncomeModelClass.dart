import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

EditIncomeModelClass editIncomeModelClassFromJson(String str) => EditIncomeModelClass.fromJson(json.decode(str));
String editIncomeModelClassToJson(EditIncomeModelClass data) => json.encode(data.toJson());
class EditIncomeModelClass {
  EditIncomeModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditIncomeModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json['errors'];
  }
  int? _statusCode;
  String? _data;
EditIncomeModelClass copyWith({  int? statusCode,
  String? data,
}) => EditIncomeModelClass(  statusCode: statusCode ?? _statusCode,
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