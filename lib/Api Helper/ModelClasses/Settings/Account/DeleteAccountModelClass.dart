import 'dart:convert';
/// StatusCode : 6000
/// data : "test Successfully Deleted"

DeleteAccountModelClass deleteAccountModelClassFromJson(String str) => DeleteAccountModelClass.fromJson(json.decode(str));
String deleteAccountModelClassToJson(DeleteAccountModelClass data) => json.encode(data.toJson());
class DeleteAccountModelClass {
  DeleteAccountModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteAccountModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json['errors'];
  }
  int? _statusCode;
  String? _data;
DeleteAccountModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteAccountModelClass(  statusCode: statusCode ?? _statusCode,
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