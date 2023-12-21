import 'dart:convert';
/// StatusCode : 6000
/// data : "Successfully Updated"

EditCountryModelClass editCountryModelClassFromJson(String str) => EditCountryModelClass.fromJson(json.decode(str));
String editCountryModelClassToJson(EditCountryModelClass data) => json.encode(data.toJson());
class EditCountryModelClass {
  EditCountryModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EditCountryModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
EditCountryModelClass copyWith({  int? statusCode,
  String? data,
}) => EditCountryModelClass(  statusCode: statusCode ?? _statusCode,
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