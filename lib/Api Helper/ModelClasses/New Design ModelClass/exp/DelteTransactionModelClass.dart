import 'dart:convert';
/// StatusCode : 6000
/// data : "Finances Successfully Deleted"

DelteTransactionModelClass delteTransactionModelClassFromJson(String str) => DelteTransactionModelClass.fromJson(json.decode(str));
String delteTransactionModelClassToJson(DelteTransactionModelClass data) => json.encode(data.toJson());
class DelteTransactionModelClass {
  DelteTransactionModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DelteTransactionModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
DelteTransactionModelClass copyWith({  int? statusCode,
  String? data,
}) => DelteTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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