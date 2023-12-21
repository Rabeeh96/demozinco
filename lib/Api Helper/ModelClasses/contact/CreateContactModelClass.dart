import 'dart:convert';

/// StatusCode : 6000
/// data : "Doors&Glass Successfully Created"

CreateContacModelClass createContacModelClassFromJson(String str) =>
    CreateContacModelClass.fromJson(json.decode(str));
String createContacModelClassToJson(CreateContacModelClass data) =>
    json.encode(data.toJson());

class CreateContacModelClass {
  CreateContacModelClass({
    int? statusCode,
    String? data,
  }) {
    _statusCode = statusCode;
    _data = data;
  }

  CreateContacModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["errors"];
  }
  int? _statusCode;
  String? _data;
  CreateContacModelClass copyWith({
    int? statusCode,
    String? data,
  }) =>
      CreateContacModelClass(
        statusCode: statusCode ?? _statusCode,
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
