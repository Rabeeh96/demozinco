import 'dart:convert';
/// StatusCode : 6000
/// data : "rounding Successfully Updated"

ChangeRoundimgModelClass changeRoundimgModelClassFromJson(String str) => ChangeRoundimgModelClass.fromJson(json.decode(str));
String changeRoundimgModelClassToJson(ChangeRoundimgModelClass data) => json.encode(data.toJson());
class ChangeRoundimgModelClass {
  ChangeRoundimgModelClass({
      int? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ChangeRoundimgModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  int? _statusCode;
  String? _data;
ChangeRoundimgModelClass copyWith({  int? statusCode,
  String? data,
}) => ChangeRoundimgModelClass(  statusCode: statusCode ?? _statusCode,
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