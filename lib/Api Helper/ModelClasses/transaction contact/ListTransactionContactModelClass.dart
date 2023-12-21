/// StatusCode : 6000
/// data : [{"id":"5be77531-a474-48f0-867f-b5c77f830248","from_account":{"id":"edd05e7b-7421-48c2-b10e-3d247f4eb327","account_name":"abhi suganya"},"to_account":{"id":"edd05e7b-7421-48c2-b10e-3d247f4eb327","account_name":"abhi suganya"},"time":"02:25 PM","created_user_id":1,"updated_user_id":1,"created_date":"2023-06-24T03:39:19.308250Z","updated_date":"2023-06-25T08:55:26.603509Z","action":"M","is_delete":false,"transaction_id":5,"date":"2023-06-25","amount":"5888.00000000","description":"","transaction_type":"0","is_reminder":false,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"},null]
/// summary : {"total_recieved":6113.0,"total_paid":5971.0}

class ListTransactionContactModelClass {
  ListTransactionContactModelClass({
      num? statusCode, 
      List<Data>? data, 
      Summary? summary,}){
    _statusCode = statusCode;
    _data = data;
    _summary = summary;
}

  ListTransactionContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  num? _statusCode;
  List<Data>? _data;
  Summary? _summary;
ListTransactionContactModelClass copyWith({  num? statusCode,
  List<Data>? data,
  Summary? summary,
}) => ListTransactionContactModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  summary: summary ?? _summary,
);
  num? get statusCode => _statusCode;
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

/// total_recieved : 6113.0
/// total_paid : 5971.0

class Summary {
  Summary({
      String? totalReceived,
    String? totalPaid,
    String? phoneNumber,
    String? contactName,
  }){
    _totalReceived = totalReceived;
    _totalPaid = totalPaid;
    _phoneNumber = phoneNumber;
    _contactName = contactName;
}

  Summary.fromJson(dynamic json) {
    _totalReceived = json['total_income'].toString();
    _totalPaid = json['total_expense'].toString();
    _contactName = json['account_name'].toString();
    _phoneNumber= json['phone'].toString();
  }
  String? _totalReceived;
  String? _totalPaid;
  String? _phoneNumber;
  String? _contactName;
Summary copyWith({
  String? totalReceived,
  String? totalPaid,
  String? phoneNumber,
  String? contactName,
}) => Summary(
  totalReceived: totalReceived ?? _totalReceived,
  totalPaid: totalPaid ?? _totalPaid,
  phoneNumber: phoneNumber ?? _phoneNumber,
  contactName: contactName ?? _contactName,
);
  String? get totalRecieved => _totalReceived;
  String? get totalPaid => _totalPaid;
  String? get phoneNumber => _phoneNumber;
  String? get contactName => _contactName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_recieved'] = _totalReceived;
    map['total_paid'] = _totalPaid;
    map['phone'] = _phoneNumber;
    map['account_name'] = _contactName;
    return map;
  }

}

/// id : "5be77531-a474-48f0-867f-b5c77f830248"
/// from_account : {"id":"edd05e7b-7421-48c2-b10e-3d247f4eb327","account_name":"abhi suganya"}
/// to_account : {"id":"edd05e7b-7421-48c2-b10e-3d247f4eb327","account_name":"abhi suganya"}
/// time : "02:25 PM"
/// created_user_id : 1
/// updated_user_id : 1
/// created_date : "2023-06-24T03:39:19.308250Z"
/// updated_date : "2023-06-25T08:55:26.603509Z"
/// action : "M"
/// is_delete : false
/// transaction_id : 5
/// date : "2023-06-25"
/// amount : "5888.00000000"
/// description : ""
/// transaction_type : "0"
/// is_reminder : false
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

class Data {
  Data({
      String? id, 
      FromAccount? fromAccount, 
      ToAccount? toAccount, 
      String? time, 
      num? createdUserId, 
      num? updatedUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action,
      String? phone,
      bool? isDelete,
      num? transactionId, 
      String? date, 
      String? amount, 
      String? description, 
      String? transactionType, 
      bool? isReminder, 
      String? organization,}){
    _id = id;
    _fromAccount = fromAccount;
    _toAccount = toAccount;
    _time = time;
    _createdUserId = createdUserId;
    _updatedUserId = updatedUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
    _transactionId = transactionId;
    _date = date;
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
    _time = json['time'];
    _createdUserId = json['created_user_id'];
    _updatedUserId = json['updated_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _transactionId = json['transaction_id'];
    _date = json['date'];
    _amount = json['amount'];
    _phone = json['phone']??'';
    _description = json['description'];
    _transactionType = json['transaction_type']??json['finance_type'];
    _isReminder = json['is_reminder'];
    _organization = json['organization'];
  }
  String? _id;
  FromAccount? _fromAccount;
  ToAccount? _toAccount;
  String? _time;
  num? _createdUserId;
  num? _updatedUserId;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  String? _phone;
  bool? _isDelete;
  num? _transactionId;
  String? _date;
  String? _amount;
  String? _description;
  String? _transactionType;
  bool? _isReminder;
  String? _organization;
Data copyWith({  String? id,
  FromAccount? fromAccount,
  ToAccount? toAccount,
  String? time,
  num? createdUserId,
  num? updatedUserId,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  num? transactionId,
  String? date,
  String? phone,
  String? amount,
  String? description,
  String? transactionType,
  bool? isReminder,
  String? organization,
}) => Data(  id: id ?? _id,
  fromAccount: fromAccount ?? _fromAccount,
  toAccount: toAccount ?? _toAccount,
  time: time ?? _time,
  createdUserId: createdUserId ?? _createdUserId,
  updatedUserId: updatedUserId ?? _updatedUserId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  transactionId: transactionId ?? _transactionId,
  date: date ?? _date,
  amount: amount ?? _amount,
  phone: phone ?? _phone,
  description: description ?? _description,
  transactionType: transactionType ?? _transactionType,
  isReminder: isReminder ?? _isReminder,
  organization: organization ?? _organization,
);
  String? get id => _id;
  FromAccount? get fromAccount => _fromAccount;
  ToAccount? get toAccount => _toAccount;
  String? get time => _time;
  num? get createdUserId => _createdUserId;
  num? get updatedUserId => _updatedUserId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  String? get phone => _phone;
  bool? get isDelete => _isDelete;
  num? get transactionId => _transactionId;
  String? get date => _date;
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
    map['time'] = _time;
    map['created_user_id'] = _createdUserId;
    map['updated_user_id'] = _updatedUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['phone'] = _phone;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['transaction_id'] = _transactionId;
    map['date'] = _date;
    map['amount'] = _amount;
    map['description'] = _description;
    map['transaction_type'] = _transactionType;
    map['is_reminder'] = _isReminder;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "edd05e7b-7421-48c2-b10e-3d247f4eb327"
/// account_name : "abhi suganya"

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

/// id : "edd05e7b-7421-48c2-b10e-3d247f4eb327"
/// account_name : "abhi suganya"

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