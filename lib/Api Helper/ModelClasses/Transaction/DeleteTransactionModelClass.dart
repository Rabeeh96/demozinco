import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Deleted"

DeleteTransactionModelClass deleteTransactionModelClassFromJson(String str) => DeleteTransactionModelClass.fromJson(json.decode(str));
String deleteTransactionModelClassToJson(DeleteTransactionModelClass data) => json.encode(data.toJson());
class DeleteTransactionModelClass {
  DeleteTransactionModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteTransactionModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DeleteTransactionModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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