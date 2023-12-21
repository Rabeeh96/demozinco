import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

EditTransactiomModelClass editTransactiomModelClassFromJson(String str) => EditTransactiomModelClass.fromJson(json.decode(str));
String editTransactiomModelClassToJson(EditTransactiomModelClass data) => json.encode(data.toJson());
class EditTransactiomModelClass {
  EditTransactiomModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditTransactiomModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
EditTransactiomModelClass copyWith({  int? statusCode,
  String? data,
}) => EditTransactiomModelClass(  statusCode: statusCode ?? _statusCode,
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