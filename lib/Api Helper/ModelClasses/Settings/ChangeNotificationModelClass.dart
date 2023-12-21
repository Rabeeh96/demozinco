import 'dart:convert';
/// StatusCode : 6000
/// data : "is_interest Successfully Updated"

ChangeNotificationModelClass changeNotificationModelClassFromJson(String str) => ChangeNotificationModelClass.fromJson(json.decode(str));
String changeNotificationModelClassToJson(ChangeNotificationModelClass data) => json.encode(data.toJson());
class ChangeNotificationModelClass {
  ChangeNotificationModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeNotificationModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeNotificationModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeNotificationModelClass(  statusCode: statusCode ?? _statusCode,
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