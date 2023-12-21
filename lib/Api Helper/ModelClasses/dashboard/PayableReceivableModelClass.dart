import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed"
/// data : [{"id":"b45358bf-0fb4-4246-b63b-82c0576d4757","account_name":"D","amount":2605.0},{"id":"6238defa-a566-4002-a81a-a664859d87f8","account_name":"Y","amount":3555.0},{"id":"a3a29f4f-2894-49f7-ba03-d59b06eb93c0","account_name":"Gf","amount":255.0}]

PayableReceivableModelClass payableReceivableModelClassFromJson(String str) => PayableReceivableModelClass.fromJson(json.decode(str));
String payableReceivableModelClassToJson(PayableReceivableModelClass data) => json.encode(data.toJson());
class PayableReceivableModelClass {
  PayableReceivableModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  PayableReceivableModelClass.fromJson(dynamic json) {
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
PayableReceivableModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => PayableReceivableModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "b45358bf-0fb4-4246-b63b-82c0576d4757"
/// account_name : "D"
/// amount : 2605.0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? accountName, 
      String? amount,}){
    _id = id;
    _accountName = accountName;
    _amount = amount;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _amount = json['amount'].toString();
  }
  String? _id;
  String? _accountName;
  String? _amount;
Data copyWith({  String? id,
  String? accountName,
  String? amount,
}) => Data(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get accountName => _accountName;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    return map;
  }

}