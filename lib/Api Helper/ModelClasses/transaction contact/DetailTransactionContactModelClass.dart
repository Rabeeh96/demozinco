import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"a8ae2c11-d52e-412d-81c9-9ee01ab2125c","from_account":{"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"},"to_account":{"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"},"created_date":"2023-05-27T11:56:59.593783Z","updated_date":"2023-05-27T11:56:59.593809Z","action":"A","is_delete":false,"transaction_id":1,"date":"2023-05-15","time":"09:30:00","amount":"100.00000000","description":"Transaction description","transaction_type":"0","is_reminder":false,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailTransactionContactModelClass detailTransactionContactModelClassFromJson(String str) => DetailTransactionContactModelClass.fromJson(json.decode(str));
String detailTransactionContactModelClassToJson(DetailTransactionContactModelClass data) => json.encode(data.toJson());
class DetailTransactionContactModelClass {
  DetailTransactionContactModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailTransactionContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailTransactionContactModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailTransactionContactModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "a8ae2c11-d52e-412d-81c9-9ee01ab2125c"
/// from_account : {"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"}
/// to_account : {"id":"08ee1d13-03cb-4e5e-8f58-81c8909c17d3","account_name":"Test"}
/// created_date : "2023-05-27T11:56:59.593783Z"
/// updated_date : "2023-05-27T11:56:59.593809Z"
/// action : "A"
/// is_delete : false
/// transaction_id : 1
/// date : "2023-05-15"
/// time : "09:30:00"
/// amount : "100.00000000"
/// description : "Transaction description"
/// transaction_type : "0"
/// is_reminder : false
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      FromAccount? fromAccount, 
      ToAccount? toAccount, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      int? transactionId, 
      String? date, 
      String? time, 
      String? amount, 
      String? description, 
      String? reminderDate,
      String? transactionType,
      bool? isReminder, 
      String? organization,}){
    _id = id;
    _fromAccount = fromAccount;
    _toAccount = toAccount;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _reminderDate = reminderDate;
    _isDelete = isDelete;
    _transactionId = transactionId;
    _date = date;
    _time = time;
    _amount = amount;
    _description = description;
    _transactionType = transactionType;
    _isReminder = isReminder;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fromAccount = json['from_account'] != null ? FromAccount.fromJson(json['from_account']) : null;
    _toAccount = json['to_account'] != null ? ToAccount.fromJson(json['to_account']) : null;
    _createdDate = json['created_date'];
    _reminderDate = json['reminder_date']??'';
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _transactionId = json['transaction_id'];
    _date = json['date'];
    _time = json['time'];
    _amount = json['amount'];
    _description = json['description'];
    _transactionType = json['transaction_type']??json['finance_type'];
    _isReminder = json['is_reminder'];
    _organization = json['organization'];
  }
  String? _id;
  FromAccount? _fromAccount;
  ToAccount? _toAccount;
  String? _createdDate;
  String? _reminderDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  int? _transactionId;
  String? _date;
  String? _time;
  String? _amount;
  String? _description;
  String? _transactionType;
  bool? _isReminder;
  String? _organization;
Data copyWith({  String? id,
  FromAccount? fromAccount,
  ToAccount? toAccount,
  String? createdDate,
  String? updatedDate,
  String? reminderDate,
  String? action,
  bool? isDelete,
  int? transactionId,
  String? date,
  String? time,
  String? amount,
  String? description,
  String? transactionType,
  bool? isReminder,
  String? organization,
}) => Data(  id: id ?? _id,
  fromAccount: fromAccount ?? _fromAccount,
  toAccount: toAccount ?? _toAccount,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  transactionId: transactionId ?? _transactionId,
  date: date ?? _date,
  time: time ?? _time,
  amount: amount ?? _amount,
  reminderDate: reminderDate ?? _reminderDate,
  description: description ?? _description,
  transactionType: transactionType ?? _transactionType,
  isReminder: isReminder ?? _isReminder,
  organization: organization ?? _organization,
);
  String? get id => _id;
  FromAccount? get fromAccount => _fromAccount;
  ToAccount? get toAccount => _toAccount;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get transactionId => _transactionId;
  String? get date => _date;
  String? get reminderDate => _reminderDate;
  String? get time => _time;
  String? get amount => _amount;
  String? get description => _description;
  String? get transactionType => _transactionType;
  bool? get isReminder => _isReminder;
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
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['reminderDate'] = _reminderDate;
    map['transaction_id'] = _transactionId;
    map['date'] = _date;
    map['time'] = _time;
    map['amount'] = _amount;
    map['description'] = _description;
    map['transaction_type'] = _transactionType;
    map['is_reminder'] = _isReminder;
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