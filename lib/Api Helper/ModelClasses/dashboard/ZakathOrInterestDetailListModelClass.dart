import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed"
/// data : [{"date":"2023-09-08","total":-2500.0,"result":[{"id":"33cd32b7-e28d-42ba-b98f-0dd8d3bec4b9","account_name":"Expe","voucher_type":"EX","amount":2500.0}]}]

ZakathOrInterestDetailListModelClass zakathOrInterestDetailListModelClassFromJson(String str) => ZakathOrInterestDetailListModelClass.fromJson(json.decode(str));
String zakathOrInterestDetailListModelClassToJson(ZakathOrInterestDetailListModelClass data) => json.encode(data.toJson());
class ZakathOrInterestDetailListModelClass {
  ZakathOrInterestDetailListModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ZakathOrInterestDetailListModelClass.fromJson(dynamic json) {
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
ZakathOrInterestDetailListModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => ZakathOrInterestDetailListModelClass(  statusCode: statusCode ?? _statusCode,
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

/// date : "2023-09-08"
/// total : -2500.0
/// result : [{"id":"33cd32b7-e28d-42ba-b98f-0dd8d3bec4b9","account_name":"Expe","voucher_type":"EX","amount":2500.0}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? date, 
      String? total,
      List<Result>? result,}){
    _date = date;
    _total = total;
    _result = result;
}

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _total = json['total'].toString();
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _date;
  String? _total;
  List<Result>? _result;
Data copyWith({  String? date,
  String? total,
  List<Result>? result,
}) => Data(  date: date ?? _date,
  total: total ?? _total,
  result: result ?? _result,
);
  String? get date => _date;
  String? get total => _total;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['total'] = _total;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "33cd32b7-e28d-42ba-b98f-0dd8d3bec4b9"
/// account_name : "Expe"
/// voucher_type : "EX"
/// amount : 2500.0

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? id, 
      String? accountName, 
      String? voucherType, 
      String? amount,}){
    _id = id;
    _accountName = accountName;
    _voucherType = voucherType;
    _amount = amount;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _voucherType = json['voucher_type'];
    _amount = json['amount'].toString();
  }
  String? _id;
  String? _accountName;
  String? _voucherType;
  String? _amount;
Result copyWith({  String? id,
  String? accountName,
  String? voucherType,
  String? amount,
}) => Result(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  voucherType: voucherType ?? _voucherType,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get accountName => _accountName;
  String? get voucherType => _voucherType;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['voucher_type'] = _voucherType;
    map['amount'] = _amount;
    return map;
  }

}