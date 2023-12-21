import 'dart:convert';

/// StatusCode : 6000
/// data : "Sample t Successfully Deleted"

DeleteContactModel deleteContactModelFromJson(String str) =>
    DeleteContactModel.fromJson(json.decode(str));
String deleteContactModelToJson(DeleteContactModel data) =>
    json.encode(data.toJson());

class DeleteContactModel {
  DeleteContactModel({
    int? statusCode,
    String? data,
  }) {
    _statusCode = statusCode;
    _data = data;
  }

  DeleteContactModel.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json['errors'];
  }
  int? _statusCode;
  String? _data;
  DeleteContactModel copyWith({
    int? statusCode,
    String? data,
  }) =>
      DeleteContactModel(
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
