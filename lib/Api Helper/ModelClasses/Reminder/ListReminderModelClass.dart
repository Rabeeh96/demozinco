import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"be697e4e-55c1-4911-81e4-d9f9b18644ce","master_name":"my","master_id":2,"voucher_type":"LON","amount":"200.00000000","day":"in 1 Days","transaction_type":1,"account":"24365758-d9be-4efb-aa5f-f1b59a60ae10","account_name":"my","account_balance":"0E-8","reminder_cycle":2},null]

ListReminderModelClass listReminderModelClassFromJson(String str) => ListReminderModelClass.fromJson(json.decode(str));
String listReminderModelClassToJson(ListReminderModelClass data) => json.encode(data.toJson());
class ListReminderModelClass {
  ListReminderModelClass({
    int? statusCode,
    List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
  }

  ListReminderModelClass.fromJson(dynamic json) {
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
  ListReminderModelClass copyWith({  int? statusCode,
    List<Data>? data,
  }) => ListReminderModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "be697e4e-55c1-4911-81e4-d9f9b18644ce"
/// master_name : "my"
/// master_id : 2
/// voucher_type : "LON"
/// amount : "200.00000000"
/// day : "in 1 Days"
/// transaction_type : 1
/// account : "24365758-d9be-4efb-aa5f-f1b59a60ae10"
/// account_name : "my"
/// account_balance : "0E-8"
/// reminder_cycle : 2

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? id,
    String? masterName,
    int? masterId,
    String? voucherType,
    String? amount,
    String? account_type,
    String? day,
    int? transactionType,
    String? account,
    String? accountName,
    String? accountBalance,
    int? reminderCycle,}){
    _id = id;
    _masterName = masterName;
    _masterId = masterId;
    _account_type = account_type;
    _voucherType = voucherType;
    _amount = amount;
    _day = day;
    _transactionType = transactionType;
    _account = account;
    _accountName = accountName;
    _accountBalance = accountBalance;
    _reminderCycle = reminderCycle;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _masterName = json['master_name'];
    _masterId = json['master_id'];
    _voucherType = json['voucher_type'];
    _account_type = json['account_type'];
    _amount = json['amount'];
    _day = json['day'];
    _transactionType = json['transaction_type'];
    _account = json['account'];
    _accountName = json['account_name'];
    _accountBalance = json['account_balance'];
    _reminderCycle = json['reminder_cycle'];
  }
  String? _id;
  String? _masterName;
  int? _masterId;
  String? _voucherType;
  String? _amount;
  String? _day;
  int? _transactionType;
  String? _account;
  String? _account_type;
  String? _accountName;
  String? _accountBalance;
  int? _reminderCycle;
  Data copyWith({  String? id,
    String? masterName,
    int? masterId,
    String? voucherType,
    String? amount,
    String? day,
    int? transactionType,
    String? account,
    String? account_type,
    String? accountName,
    String? accountBalance,
    int? reminderCycle,
  }) => Data(  id: id ?? _id,
    masterName: masterName ?? _masterName,
    masterId: masterId ?? _masterId,
    voucherType: voucherType ?? _voucherType,
    amount: amount ?? _amount,
    day: day ?? _day,
    transactionType: transactionType ?? _transactionType,
    account: account ?? _account,
    accountName: accountName ?? _accountName,
    account_type: account_type ?? _account_type,
    accountBalance: accountBalance ?? _accountBalance,
    reminderCycle: reminderCycle ?? _reminderCycle,
  );
  String? get id => _id;
  String? get masterName => _masterName;
  int? get masterId => _masterId;
  String? get voucherType => _voucherType;
  String? get amount => _amount;
  String? get day => _day;
  int? get transactionType => _transactionType;
  String? get account => _account;
  String? get accountName => _accountName;
  String? get account_type => _account_type;
  String? get accountBalance => _accountBalance;
  int? get reminderCycle => _reminderCycle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['master_name'] = _masterName;
    map['master_id'] = _masterId;
    map['voucher_type'] = _voucherType;
    map['amount'] = _amount;
    map['day'] = _day;
    map['account_type'] = _account_type;
    map['transaction_type'] = _transactionType;
    map['account'] = _account;
    map['account_name'] = _accountName;
    map['account_balance'] = _accountBalance;
    map['reminder_cycle'] = _reminderCycle;
    return map;
  }
}