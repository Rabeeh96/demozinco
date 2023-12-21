import 'dart:convert';
/// StatusCode : 6000
/// data : [{"date":"2023-08-09","total":6045.9,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":123.3,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":5335.3,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"}]},{"date":"2023-08-10","total":1587.8,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1000.5,"description":"","voucher_type":"EX"}]},{"date":"2023-08-11","total":14000.0,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":6000.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-12","total":8000.0,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-13","total":23000.0,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":8000.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":15000.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-14","total":9000.0,"data":[{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":1500.0,"description":"","voucher_type":"EX"}]}]

IncomeTransactionModelClass transactionExpenseModelClassFromJson(String str) => IncomeTransactionModelClass.fromJson(json.decode(str));
String transactionExpenseModelClassToJson(IncomeTransactionModelClass data) => json.encode(data.toJson());
class IncomeTransactionModelClass {
  IncomeTransactionModelClass({
    int? statusCode,
    List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
  }

  IncomeTransactionModelClass.fromJson(dynamic json) {
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
  IncomeTransactionModelClass copyWith({  int? statusCode,
    List<Data>? data,
  }) => IncomeTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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
/// total : 6045.9
/// data : [{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":123.3,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":5335.3,"description":"","voucher_type":"EX"},{"from_account_name":"SBI Bank","to_account_name":"Expense 4","amount":587.3,"description":"","voucher_type":"EX"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? date,
    String? total,
    List<DetailData>? detailData,}){
    _date = date;
    _total = total;
    _data = detailData;
  }

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _total = json['total'].toString();
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DetailData.fromJson(v));
      });
    }
  }
  String? _date;
  String? _total;
  List<DetailData>? _data;
  Data copyWith({  String? date,
    String? total,
    List<DetailData>? detailData,
  }) => Data(  date: date ?? _date,
    total: total ?? _total,
    detailData: data ?? _data,
  );
  String? get date => _date;
  String? get total => _total;
  List<DetailData>? get data => _data;

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

/// from_account_name : "SBI Bank"
/// to_account_name : "Expense 4"
/// amount : 123.3
/// description : ""
/// voucher_type : "EX"

Data detailFromJson(String str) => Data.fromJson(json.decode(str));
String detailToJson(Data data) => json.encode(data.toJson());
class DetailData {
  DetailData({
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

  DetailData.fromJson(dynamic json) {
    _id = json["id"];
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
  DetailData copyWith({
    String? id,
    String? fromAccountName,
    String? toAccountName,
    String? amount,
    String? description,
    String? voucherType,
  }) => DetailData(
    id: id ?? _id,
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