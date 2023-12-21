import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Deleted"

DeleteCountryModelClass deleteCountryModelClassFromJson(String str) => DeleteCountryModelClass.fromJson(json.decode(str));
String deleteCountryModelClassToJson(DeleteCountryModelClass data) => json.encode(data.toJson());
class DeleteCountryModelClass {
  DeleteCountryModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteCountryModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["errors"];
  }
  int? _statusCode;
  String? _data;
DeleteCountryModelClass copyWith({  int? statusCode,
  String? data,
}) => DeleteCountryModelClass(  statusCode: statusCode ?? _statusCode,
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