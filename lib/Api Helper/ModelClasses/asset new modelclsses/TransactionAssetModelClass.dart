import 'dart:convert';
/// StatusCode : 6000
/// data : [{"date":"2023-08-11","total":56040528.0,"data":[{"id":"0dd6acf4-b61a-48bc-b990-2ec3ad70bc05","from_account_name":"Bank","to_account_name":"Changing","amount":5555.0,"description":"","voucher_type":"EX"},{"id":"f7155fb7-5305-49ca-85be-794036e70f36","from_account_name":"Bank","to_account_name":"Stoning","amount":22222.0,"description":"","voucher_type":"EX"},{"id":"69f4074f-9c01-4295-b029-fe1105da2c65","from_account_name":"Nashid bank","to_account_name":"Changing","amount":652.0,"description":"","voucher_type":"EX"},{"id":"37801c19-0cd2-4ed5-80c2-1d0b54bc6d67","from_account_name":"Bank","to_account_name":"Stoning","amount":55555955.0,"description":"","voucher_type":"EX"},{"id":"5f36a361-a382-4e22-a145-ef04b50867aa","from_account_name":"ICICI Bank","to_account_name":"Changing","amount":200000.0,"description":"","voucher_type":"EX"},{"id":"b952f723-c1ce-4b1a-853b-93394b9f61ac","from_account_name":"Bank","to_account_name":"Mi Dlt","amount":522.0,"description":"","voucher_type":"EX"},{"id":"771e344a-6b5f-4338-b74b-7851b96bf206","from_account_name":"Bank","to_account_name":"Dennis","amount":255622.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-12","total":54555.0,"data":[{"id":"307b59ff-1571-4d52-b8cc-ddc074fda503","from_account_name":"SBI Bank","to_account_name":"Dennis","amount":54555.0,"description":"","voucher_type":"EX"}]},{"date":"2023-08-25","total":16171.0,"data":[{"id":"58cb3fb6-1afe-47ed-a478-71aa22ff1f4b","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":254.0,"description":"","voucher_type":"EX"},{"id":"287e129f-95a0-4e87-859c-814584e7c8bc","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":365.0,"description":"","voucher_type":"AEX"},{"id":"d30974b5-725d-44dc-b05c-ffcec8fed637","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":1520.0,"description":"","voucher_type":"AEX"},{"id":"5ff29b5d-da88-41c8-8a8b-2df2eaa08bf9","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":254.0,"description":"","voucher_type":"AEX"},{"id":"bc738515-f363-46a2-b10f-068e0e9d7560","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":365.0,"description":"","voucher_type":"AEX"},{"id":"3ba0c3cb-d9df-48ed-b9ae-72eef75fe1d7","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":874.0,"description":"","voucher_type":"AEX"},{"id":"6fd6576d-2036-40c1-a1c3-674261e110e9","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":7854.0,"description":"","voucher_type":"AEX"},{"id":"94935efb-2cd7-421f-aa01-2ee2a102dce4","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":987.0,"description":"","voucher_type":"AEX"},{"id":"386f571b-bea0-43c0-a005-a0cab690d357","from_account_name":"SBI Bank","to_account_name":"Mi Dlt","amount":3698.0,"description":"","voucher_type":"AEX"}]}]

TransactionAssetModelClass transactionAssetModelClassFromJson(String str) => TransactionAssetModelClass.fromJson(json.decode(str));
String transactionAssetModelClassToJson(TransactionAssetModelClass data) => json.encode(data.toJson());
class TransactionAssetModelClass {
  TransactionAssetModelClass({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  TransactionAssetModelClass.fromJson(dynamic json) {
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
TransactionAssetModelClass copyWith({  int? statusCode,
  List<Data>? data,
}) => TransactionAssetModelClass(  statusCode: statusCode ?? _statusCode,
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

/// date : "2023-08-11"
/// total : 56040528.0
/// data : [{"id":"0dd6acf4-b61a-48bc-b990-2ec3ad70bc05","from_account_name":"Bank","to_account_name":"Changing","amount":5555.0,"description":"","voucher_type":"EX"},{"id":"f7155fb7-5305-49ca-85be-794036e70f36","from_account_name":"Bank","to_account_name":"Stoning","amount":22222.0,"description":"","voucher_type":"EX"},{"id":"69f4074f-9c01-4295-b029-fe1105da2c65","from_account_name":"Nashid bank","to_account_name":"Changing","amount":652.0,"description":"","voucher_type":"EX"},{"id":"37801c19-0cd2-4ed5-80c2-1d0b54bc6d67","from_account_name":"Bank","to_account_name":"Stoning","amount":55555955.0,"description":"","voucher_type":"EX"},{"id":"5f36a361-a382-4e22-a145-ef04b50867aa","from_account_name":"ICICI Bank","to_account_name":"Changing","amount":200000.0,"description":"","voucher_type":"EX"},{"id":"b952f723-c1ce-4b1a-853b-93394b9f61ac","from_account_name":"Bank","to_account_name":"Mi Dlt","amount":522.0,"description":"","voucher_type":"EX"},{"id":"771e344a-6b5f-4338-b74b-7851b96bf206","from_account_name":"Bank","to_account_name":"Dennis","amount":255622.0,"description":"","voucher_type":"EX"}]

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

/// id : "0dd6acf4-b61a-48bc-b990-2ec3ad70bc05"
/// from_account_name : "Bank"
/// to_account_name : "Changing"
/// amount : 5555.0
/// description : ""
/// voucher_type : "EX"

Data dataDetailFromJson(String str) => Data.fromJson(json.decode(str));
String dataDetailToJson(Data data) => json.encode(data.toJson());
class DataDetail {
  Data({
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
}) => Data(  id: id ?? _id,
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