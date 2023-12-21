import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"277022ab-b886-45e8-aa5f-df4e86ebabdb","from_account":{"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"},"to_account":{"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"},"created_user_id":1,"action":"A","is_delete":false,"finance_id":1,"finance_type":"0","date":"2023-05-27","time":"10:30:00","amount":"20.00000000","description":"income create","is_interest":false,"is_zakath":false,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}]

ListIncomeModelClass listIncomeModelClassFromJson(String str) => ListIncomeModelClass.fromJson(json.decode(str));
String listIncomeModelClassToJson(ListIncomeModelClass data) => json.encode(data.toJson());
class ListIncomeModelClass {
  ListIncomeModelClass({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ListIncomeModelClass.fromJson(dynamic json) {
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
ListIncomeModelClass copyWith({  int? statusCode,
  List<Data>? data,
}) => ListIncomeModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "277022ab-b886-45e8-aa5f-df4e86ebabdb"
/// from_account : {"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"}
/// to_account : {"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"}
/// created_user_id : 1
/// action : "A"
/// is_delete : false
/// finance_id : 1
/// finance_type : "0"
/// date : "2023-05-27"
/// time : "10:30:00"
/// amount : "20.00000000"
/// description : "income create"
/// is_interest : false
/// is_zakath : false
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      FromAccount? fromAccount, 
      ToAccount? toAccount, 
      int? createdUserId, 
      String? action, 
      bool? isDelete, 
      int? financeId, 
      String? financeType, 
      String? date, 
      String? time, 
      String? amount, 
      String? description, 
      bool? isInterest, 
      bool? isZakath, 
      String? organization,}){
    _id = id;
    _fromAccount = fromAccount;
    _toAccount = toAccount;
    _createdUserId = createdUserId;
    _action = action;
    _isDelete = isDelete;
    _financeId = financeId;
    _financeType = financeType;
    _date = date;
    _time = time;
    _amount = amount;
    _description = description;
    _isInterest = isInterest;
    _isZakath = isZakath;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fromAccount = json['from_account'] != null ? FromAccount.fromJson(json['from_account']) : null;
    _toAccount = json['to_account'] != null ? ToAccount.fromJson(json['to_account']) : null;
    _createdUserId = json['created_user_id'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _financeId = json['finance_id'];
    _financeType = json['finance_type'];
    _date = json['date'];
    _time = json['time'];
    _amount = json['amount'];
    _description = json['description'];
    _isInterest = json['is_interest'];
    _isZakath = json['is_zakath'];
    _organization = json['organization'];
  }
  String? _id;
  FromAccount? _fromAccount;
  ToAccount? _toAccount;
  int? _createdUserId;
  String? _action;
  bool? _isDelete;
  int? _financeId;
  String? _financeType;
  String? _date;
  String? _time;
  String? _amount;
  String? _description;
  bool? _isInterest;
  bool? _isZakath;
  String? _organization;
Data copyWith({  String? id,
  FromAccount? fromAccount,
  ToAccount? toAccount,
  int? createdUserId,
  String? action,
  bool? isDelete,
  int? financeId,
  String? financeType,
  String? date,
  String? time,
  String? amount,
  String? description,
  bool? isInterest,
  bool? isZakath,
  String? organization,
}) => Data(  id: id ?? _id,
  fromAccount: fromAccount ?? _fromAccount,
  toAccount: toAccount ?? _toAccount,
  createdUserId: createdUserId ?? _createdUserId,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  financeId: financeId ?? _financeId,
  financeType: financeType ?? _financeType,
  date: date ?? _date,
  time: time ?? _time,
  amount: amount ?? _amount,
  description: description ?? _description,
  isInterest: isInterest ?? _isInterest,
  isZakath: isZakath ?? _isZakath,
  organization: organization ?? _organization,
);
  String? get id => _id;
  FromAccount? get fromAccount => _fromAccount;
  ToAccount? get toAccount => _toAccount;
  int? get createdUserId => _createdUserId;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get financeId => _financeId;
  String? get financeType => _financeType;
  String? get date => _date;
  String? get time => _time;
  String? get amount => _amount;
  String? get description => _description;
  bool? get isInterest => _isInterest;
  bool? get isZakath => _isZakath;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_fromAccount != null) {
      map['from_account'] = _fromAccount?.toJson();
    }
    if (_toAccount != null) {
      map['to_account'] = _toAccount?.toJson();
    }
    map['created_user_id'] = _createdUserId;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['finance_id'] = _financeId;
    map['finance_type'] = _financeType;
    map['date'] = _date;
    map['time'] = _time;
    map['amount'] = _amount;
    map['description'] = _description;
    map['is_interest'] = _isInterest;
    map['is_zakath'] = _isZakath;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "08ee1d13-03cb-4e5e-8f58-81c8909c17d3"
/// account_name : "Test"

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

/// id : "08ee1d13-03cb-4e5e-8f58-81c8909c17d3"
/// account_name : "Test"

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