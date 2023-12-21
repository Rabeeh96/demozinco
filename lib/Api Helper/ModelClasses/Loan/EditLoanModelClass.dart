import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

EditLoanModelClass editLoanModelClassFromJson(String str) => EditLoanModelClass.fromJson(json.decode(str));
String editLoanModelClassToJson(EditLoanModelClass data) => json.encode(data.toJson());
class EditLoanModelClass {
  EditLoanModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditLoanModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["errors"];
  }
  int? _statusCode;
  String? _data;
EditLoanModelClass copyWith({  int? statusCode,
  String? data,
}) => EditLoanModelClass(  statusCode: statusCode ?? _statusCode,
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