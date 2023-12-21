import 'dart:convert';
/// StatusCode : 6000
/// data : [{"date":"2023-08-14","total":1520.0,"data":[{"id":"46bfbe11-e940-404d-8847-fb46b3c12c4e","from_account_name":"SBI Bank","to_account_name":"Income 7","amount":1520.0,"description":"","voucher_type":"EX"}]}]
/// summary : {"account_name":"Income 7","balance":0.0,"total":0,"this_month":0}

ModelClassDetailExpense modelClassDetailExpenseFromJson(String str) => ModelClassDetailExpense.fromJson(json.decode(str));
String modelClassDetailExpenseToJson(ModelClassDetailExpense data) => json.encode(data.toJson());
class ModelClassDetailExpense {
  ModelClassDetailExpense({
      int? statusCode, 
      List<Data>? data, 
      Summary? summary,}){
    _statusCode = statusCode;
    _data = data;
    _summary = summary;
}

  ModelClassDetailExpense.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  int? _statusCode;
  List<Data>? _data;
  Summary? _summary;
ModelClassDetailExpense copyWith({  int? statusCode,
  List<Data>? data,
  Summary? summary,
}) => ModelClassDetailExpense(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  summary: summary ?? _summary,
);
  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  Summary? get summary => _summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    return map;
  }

}

/// account_name : "Income 7"
/// balance : 0.0
/// total : 0
/// this_month : 0

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
      String? accountName, 
      String? balance,
      String? total,
      String? thisMonth,}){
    _accountName = accountName;
    _balance = balance;
    _total = total;
    _thisMonth = thisMonth;
}

  Summary.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
    _total = json['total'].toString();
    _thisMonth = json['this_month'].toString();
  }
  String? _accountName;
  String? _balance;
  String? _total;
  String? _thisMonth;
Summary copyWith({  String? accountName,
  String? balance,
  String? total,
  String? thisMonth,
}) => Summary(  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
  total: total ?? _total,
  thisMonth: thisMonth ?? _thisMonth,
);
  String? get accountName => _accountName;
  String? get balance => _balance;
  String? get total => _total;
  String? get thisMonth => _thisMonth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    map['total'] = _total;
    map['this_month'] = _thisMonth;
    return map;
  }

}

/// date : "2023-08-14"
/// total : 1520.0
/// data : [{"id":"46bfbe11-e940-404d-8847-fb46b3c12c4e","from_account_name":"SBI Bank","to_account_name":"Income 7","amount":1520.0,"description":"","voucher_type":"EX"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? date, 
      String? total,
      List<DataDetail>? data,}){
    _date = date;
    _total = total;
    _data = data;
}

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _total = json['total'].toString();
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataDetail.fromJson(v));
      });
    }
  }
  String? _date;
  String? _total;
  List<DataDetail>? _data;
Data copyWith({  String? date,
  String? total,
  List<DataDetail>? data,
}) => Data(  date: date ?? _date,
  total: total ?? _total,
  data: data ?? _data,
);
  String? get date => _date;
  String? get total => _total;
  List<DataDetail>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "46bfbe11-e940-404d-8847-fb46b3c12c4e"
/// from_account_name : "SBI Bank"
/// to_account_name : "Income 7"
/// amount : 1520.0
/// description : ""
/// voucher_type : "EX"

Data dataDetailFromJson(String str) => Data.fromJson(json.decode(str));
String dataDetailToJson(Data data) => json.encode(data.toJson());
class DataDetail {
  DataDetail({
      String? id, 
      String? fromAccountName, 
      String? toAccountName, 
      String? amount,
      String? description, 
      String? voucherType,}){
    _id = id;
    _fromAccountName = fromAccountName;
    _toAccountName = toAccountName;
    _amount = amount;
    _description = description;
    _voucherType = voucherType;
}

  DataDetail.fromJson(dynamic json) {
    _id = json['id'];
    _fromAccountName = json['from_account_name'];
    _toAccountName = json['to_account_name'];
    _amount = json['amount'].toString();
    _description = json['description']??'';
    _voucherType = json['voucher_type'];
  }
  String? _id;
  String? _fromAccountName;
  String? _toAccountName;
  String? _amount;
  String? _description;
  String? _voucherType;
DataDetail copyWith({  String? id,
  String? fromAccountName,
  String? toAccountName,
  String? amount,
  String? description,
  String? voucherType,
}) => DataDetail(  id: id ?? _id,
  fromAccountName: fromAccountName ?? _fromAccountName,
  toAccountName: toAccountName ?? _toAccountName,
  amount: amount ?? _amount,
  description: description ?? _description,
  voucherType: voucherType ?? _voucherType,
);
  String? get id => _id;
  String? get fromAccountName => _fromAccountName;
  String? get toAccountName => _toAccountName;
  String? get amount => _amount;
  String? get description => _description;
  String? get voucherType => _voucherType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['from_account_name'] = _fromAccountName;
    map['to_account_name'] = _toAccountName;
    map['amount'] = _amount;
    map['description'] = _description;
    map['voucher_type'] = _voucherType;
    return map;
  }

}