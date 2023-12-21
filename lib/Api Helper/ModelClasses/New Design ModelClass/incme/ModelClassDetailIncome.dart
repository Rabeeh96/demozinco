import 'dart:convert';
/// StatusCode : 6000
/// data : [{"date":"2023-08-09","total":5922.6,"data":[{"id":"fc04962a-2eb5-4c3b-a8ad-2cce1185a8ad","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":5335.3,"description":"","voucher_type":"EX"},{"id":"6e990ba5-080c-4781-84c0-73d636dcbba0","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"}]},{"date":"2023-08-10","total":1587.8,"data":[{"id":"3ee913ea-666f-47c4-aa35-d5af359d2571","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"},{"id":"559f8fe4-af74-41a3-88d3-d28f748d38c3","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1000.5,"description":"","voucher_type":"EX"}]},{"date":"2023-08-11","total":14000.0,"data":[{"id":"193da282-af9f-4c0e-85a5-5aa8e0c59681","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":6000.0,"description":"","voucher_type":"EX"},{"id":"fd6df82d-a2de-46af-b3a1-fccaabf5140b","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-12","total":8000.0,"data":[{"id":"0dd76669-34d2-4176-afc7-d4e44aebf415","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-13","total":23000.0,"data":[{"id":"a3609d77-cbfb-490b-8cb4-a30bdc0f88ab","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"},{"id":"51d34572-3a8c-4dd3-8e1a-e5fb976beb71","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":15000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-14","total":9000.0,"data":[{"id":"c58ee705-6ca0-4945-88fc-3336497344aa","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"id":"fecb59ca-92f5-41a2-a5f6-246068de72bf","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"id":"58dc4010-1e4d-4d54-a2d9-669fdbea4ec8","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"id":"5ac464b7-9573-4a5a-8cde-800652f2c92e","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"id":"dcc552b7-455f-4c33-b9fa-76f9230df68a","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"id":"24652cb8-ec00-4aab-a7a4-bb45267cbaed","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"}]}]

ModelClassDetailIncome modelClassDetailIncomeFromJson(String str) => ModelClassDetailIncome.fromJson(json.decode(str));
String modelClassDetailIncomeToJson(ModelClassDetailIncome data) => json.encode(data.toJson());
class ModelClassDetailIncome {
  ModelClassDetailIncome({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ModelClassDetailIncome.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Data>? _data;
ModelClassDetailIncome copyWith({  int? statusCode,
  List<Data>? data,
}) => ModelClassDetailIncome(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2023-08-09"
/// total : 5922.6
/// data : [{"id":"fc04962a-2eb5-4c3b-a8ad-2cce1185a8ad","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":5335.3,"description":"","voucher_type":"EX"},{"id":"6e990ba5-080c-4781-84c0-73d636dcbba0","from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? date, 
      String? total,
      List<Data>? data,}){
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
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _date;
  String? _total;
  List<Data>? _data;
Data copyWith({  String? date,
  String? total,
  List<Data>? data,
}) => Data(  date: date ?? _date,
  total: total ?? _total,
  data: data ?? _data,
);
  String? get date => _date;
  String? get total => _total;
  List<Data>? get data => _data;

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

/// id : "fc04962a-2eb5-4c3b-a8ad-2cce1185a8ad"
/// from_account_name : "SBI Bank"
/// to_account_name : "Expense 4"
/// amount : 5335.3
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
    _description = json['description'];
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