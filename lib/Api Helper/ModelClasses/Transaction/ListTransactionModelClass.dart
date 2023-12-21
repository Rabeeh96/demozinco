import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"3704cb4a-a216-4770-80e9-bcb8c1970722","from_account":{"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"aabith"},"to_account":{"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"aabith"},"transfer_id":1,"date":"2023-06-01","time":"12:34:56","from_amount":"100.00000000","to_amount":"200.00000000","description":"your-description-value","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129","from_country":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","to_country":"f423fd4a-ab0f-401d-8713-eb3eb69c84df"}]

ListTransactionModelClass listTransactionModelClassFromJson(String str) => ListTransactionModelClass.fromJson(json.decode(str));
String listTransactionModelClassToJson(ListTransactionModelClass data) => json.encode(data.toJson());
class ListTransactionModelClass {
  ListTransactionModelClass({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ListTransactionModelClass.fromJson(dynamic json) {
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
ListTransactionModelClass copyWith({  int? statusCode,
  List<Data>? data,
}) => ListTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "3704cb4a-a216-4770-80e9-bcb8c1970722"
/// from_account : {"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"aabith"}
/// to_account : {"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"aabith"}
/// transfer_id : 1
/// date : "2023-06-01"
/// time : "12:34:56"
/// from_amount : "100.00000000"
/// to_amount : "200.00000000"
/// description : "your-description-value"
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"
/// from_country : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"
/// to_country : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      FromAccount? fromAccount, 
      ToAccount? toAccount, 
      int? transferId, 
      String? date, 
      String? time, 
      String? fromAmount, 
      String? toAmount, 
      String? description, 
      String? organization, 
      String? fromCountry, 
      String? toCountry,}){
    _id = id;
    _fromAccount = fromAccount;
    _toAccount = toAccount;
    _transferId = transferId;
    _date = date;
    _time = time;
    _fromAmount = fromAmount;
    _toAmount = toAmount;
    _description = description;
    _organization = organization;
    _fromCountry = fromCountry;
    _toCountry = toCountry;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fromAccount = json['from_account'] != null ? FromAccount.fromJson(json['from_account']) : null;
    _toAccount = json['to_account'] != null ? ToAccount.fromJson(json['to_account']) : null;
    _transferId = json['transfer_id'];
    _date = json['date']??"";
    _time = json['time'];
    _fromAmount = json['from_amount'];
    _toAmount = json['to_amount'];
    _description = json['description'];
    _organization = json['organization'];
    _fromCountry = json['from_country'];
    _toCountry = json['to_country'];
  }
  String? _id;
  FromAccount? _fromAccount;
  ToAccount? _toAccount;
  int? _transferId;
  String? _date;
  String? _time;
  String? _fromAmount;
  String? _toAmount;
  String? _description;
  String? _organization;
  String? _fromCountry;
  String? _toCountry;
Data copyWith({  String? id,
  FromAccount? fromAccount,
  ToAccount? toAccount,
  int? transferId,
  String? date,
  String? time,
  String? fromAmount,
  String? toAmount,
  String? description,
  String? organization,
  String? fromCountry,
  String? toCountry,
}) => Data(  id: id ?? _id,
  fromAccount: fromAccount ?? _fromAccount,
  toAccount: toAccount ?? _toAccount,
  transferId: transferId ?? _transferId,
  date: date ?? _date,
  time: time ?? _time,
  fromAmount: fromAmount ?? _fromAmount,
  toAmount: toAmount ?? _toAmount,
  description: description ?? _description,
  organization: organization ?? _organization,
  fromCountry: fromCountry ?? _fromCountry,
  toCountry: toCountry ?? _toCountry,
);
  String? get id => _id;
  FromAccount? get fromAccount => _fromAccount;
  ToAccount? get toAccount => _toAccount;
  int? get transferId => _transferId;
  String? get date => _date;
  String? get time => _time;
  String? get fromAmount => _fromAmount;
  String? get toAmount => _toAmount;
  String? get description => _description;
  String? get organization => _organization;
  String? get fromCountry => _fromCountry;
  String? get toCountry => _toCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_fromAccount != null) {
      map['from_account'] = _fromAccount?.toJson();
    }
    if (_toAccount != null) {
      map['to_account'] = _toAccount?.toJson();
    }
    map['transfer_id'] = _transferId;
    map['date'] = _date;
    map['time'] = _time;
    map['from_amount'] = _fromAmount;
    map['to_amount'] = _toAmount;
    map['description'] = _description;
    map['organization'] = _organization;
    map['from_country'] = _fromCountry;
    map['to_country'] = _toCountry;
    return map;
  }

}

/// id : "47348801-9365-42f3-b7b1-ebfb9e90ee17"
/// account_name : "aabith"

ToAccount toAccountFromJson(String str) => ToAccount.fromJson(json.decode(str));
String toAccountToJson(ToAccount data) => json.encode(data.toJson());
class ToAccount {
  ToAccount({
      String? id, 
      String? accountName,}){
    _id = id;
    _accountName = accountName;
}

  ToAccount.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
  }
  String? _id;
  String? _accountName;
ToAccount copyWith({  String? id,
  String? accountName,
}) => ToAccount(  id: id ?? _id,
  accountName: accountName ?? _accountName,
);
  String? get id => _id;
  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    return map;
  }

}

/// id : "47348801-9365-42f3-b7b1-ebfb9e90ee17"
/// account_name : "aabith"

FromAccount fromAccountFromJson(String str) => FromAccount.fromJson(json.decode(str));
String fromAccountToJson(FromAccount data) => json.encode(data.toJson());
class FromAccount {
  FromAccount({
      String? id, 
      String? accountName,}){
    _id = id;
    _accountName = accountName;
}

  FromAccount.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
  }
  String? _id;
  String? _accountName;
FromAccount copyWith({  String? id,
  String? accountName,
}) => FromAccount(  id: id ?? _id,
  accountName: accountName ?? _accountName,
);
  String? get id => _id;
  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    return map;
  }

}