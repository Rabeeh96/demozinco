import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed"
/// data : [{"account_name":"SBI","id":"23e53bab-4148-4a41-a953-1ab0f11920c8","amount":0,"account_type":1},null]

ZakathorInterestListModelClass zakathorInterestListModelClassFromJson(String str) => ZakathorInterestListModelClass.fromJson(json.decode(str));
String zakathorInterestListModelClassToJson(ZakathorInterestListModelClass data) => json.encode(data.toJson());
class ZakathorInterestListModelClass {
  ZakathorInterestListModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ZakathorInterestListModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  String? _message;
  List<Data>? _data;
ZakathorInterestListModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => ZakathorInterestListModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// account_name : "SBI"
/// id : "23e53bab-4148-4a41-a953-1ab0f11920c8"
/// amount : 0
/// account_type : 1

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? accountName, 
      String? id, 
      String? amount,
      int? accountType,}){
    _accountName = accountName;
    _id = id;
    _amount = amount;
    _accountType = accountType;
}

  Data.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _id = json['id'];
    _amount = json['amount'].toString();
    _accountType = json['account_type'];
  }
  String? _accountName;
  String? _id;
  String? _amount;
  int? _accountType;
Data copyWith({  String? accountName,
  String? id,
  String? amount,
  int? accountType,
}) => Data(  accountName: accountName ?? _accountName,
  id: id ?? _id,
  amount: amount ?? _amount,
  accountType: accountType ?? _accountType,
);
  String? get accountName => _accountName;
  String? get id => _id;
  String? get amount => _amount;
  int? get accountType => _accountType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['id'] = _id;
    map['amount'] = _amount;
    map['account_type'] = _accountType;
    return map;
  }

}