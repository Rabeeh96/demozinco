import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"9058ffa8-a28f-4c16-b5ab-a2fd8b55aadf","reminder":[{"id":"3f9f7bb9-3b6a-487a-8c07-a186d948c40d","reminder_id":45,"master_id":23,"description":"","amount":"100.00000000","reminder_cycle":"0","date":"2023-10-12"}],"account":{"id":"dd12793d-91f0-411b-823c-2581ba5bf9cb","account_name":"erp"},"from_account":"","date":"","loan_id":23,"loan_name":"erp","loan_type":"1","amount":"100.00000000","interest":"52.00000000","payment_cycle":"3","duration":"200","interest_amount":"555.00000000","processing_fee":"555.00000000","total_amount":"888.00000000","is_manual":false,"is_existing":true,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailLoanModelClass detailLoanModelClassFromJson(String str) => DetailLoanModelClass.fromJson(json.decode(str));
String detailLoanModelClassToJson(DetailLoanModelClass data) => json.encode(data.toJson());
class DetailLoanModelClass {
  DetailLoanModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailLoanModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailLoanModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailLoanModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "9058ffa8-a28f-4c16-b5ab-a2fd8b55aadf"
/// reminder : [{"id":"3f9f7bb9-3b6a-487a-8c07-a186d948c40d","reminder_id":45,"master_id":23,"description":"","amount":"100.00000000","reminder_cycle":"0","date":"2023-10-12"}]
/// account : {"id":"dd12793d-91f0-411b-823c-2581ba5bf9cb","account_name":"erp"}
/// from_account : ""
/// date : ""
/// loan_id : 23
/// loan_name : "erp"
/// loan_type : "1"
/// amount : "100.00000000"
/// interest : "52.00000000"
/// payment_cycle : "3"
/// duration : "200"
/// interest_amount : "555.00000000"
/// processing_fee : "555.00000000"
/// total_amount : "888.00000000"
/// is_manual : false
/// is_existing : true
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      List<Reminder>? reminder, 
      Account? account,
      Account? fromAccount,
      String? date, 
      String? day,
      int? loanId,
      String? loanName, 
      String? loanType, 
      String? amount, 
      String? interest, 
      String? paymentCycle, 
      String? duration, 
      String? interestAmount, 
      String? processingFee, 
      String? totalAmount, 
      bool? isManual, 
      bool? isExisting, 
      String? organization,}){
    _id = id;
    _reminder = reminder;
    _account = account;
    _fromAccount = fromAccount;
    _date = date;
    _day = day;
    _loanId = loanId;
    _loanName = loanName;
    _loanType = loanType;
    _amount = amount;
    _interest = interest;
    _paymentCycle = paymentCycle;
    _duration = duration;
    _interestAmount = interestAmount;
    _processingFee = processingFee;
    _totalAmount = totalAmount;
    _isManual = isManual;
    _isExisting = isExisting;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    if (json['reminder'] != null) {
      _reminder = [];
      json['reminder'].forEach((v) {
        _reminder?.add(Reminder.fromJson(v));
      });
    }
    _account = json['account'] != null ? Account.fromJson(json['account']) : null;
    _fromAccount = json['from_account'] != null ? Account.fromJson(json['from_account']) : null;
    _date = json['date'];
    _loanId = json['loan_id'];
    _day = json['day']??'';
    _loanName = json['loan_name'];
    _loanType = json['loan_type'];
    _amount = json['amount'].toString();
    _interest = json['interest'];
    _paymentCycle = json['payment_cycle'];
    _duration = json['duration'];
    _interestAmount = json['interest_amount'].toString();
    _processingFee = json['processing_fee'].toString();
    _totalAmount = json['total_amount'].toString();
    _isManual = json['is_manual'];
    _isExisting = json['is_existing'];
    _organization = json['organization'];
  }
  String? _id;
  List<Reminder>? _reminder;
  Account? _account;
  Account? _fromAccount;
  String? _date;
  String? _day;
  int? _loanId;
  String? _loanName;
  String? _loanType;
  String? _amount;
  String? _interest;
  String? _paymentCycle;
  String? _duration;
  String? _interestAmount;
  String? _processingFee;
  String? _totalAmount;
  bool? _isManual;
  bool? _isExisting;
  String? _organization;
Data copyWith({  String? id,
  List<Reminder>? reminder,
  Account? account,
  Account? fromAccount,
  String? date,
  int? loanId,
  String? loanName,
  String? loanType,
  String? amount,
  String? day,
  String? interest,
  String? paymentCycle,
  String? duration,
  String? interestAmount,
  String? processingFee,
  String? totalAmount,
  bool? isManual,
  bool? isExisting,
  String? organization,
}) => Data(  id: id ?? _id,
  reminder: reminder ?? _reminder,
  account: account ?? _account,
  fromAccount: fromAccount ?? _fromAccount,
  date: date ?? _date,
  loanId: loanId ?? _loanId,
  loanName: loanName ?? _loanName,
  loanType: loanType ?? _loanType,
  amount: amount ?? _amount,
  day: day ?? _day,
  interest: interest ?? _interest,
  paymentCycle: paymentCycle ?? _paymentCycle,
  duration: duration ?? _duration,
  interestAmount: interestAmount ?? _interestAmount,
  processingFee: processingFee ?? _processingFee,
  totalAmount: totalAmount ?? _totalAmount,
  isManual: isManual ?? _isManual,
  isExisting: isExisting ?? _isExisting,
  organization: organization ?? _organization,
);
  String? get id => _id;
  List<Reminder>? get reminder => _reminder;
  Account? get account => _account;
  Account? get fromAccount => _fromAccount;
  String? get date => _date;
  int? get loanId => _loanId;
  String? get loanName => _loanName;
  String? get loanType => _loanType;
   String? get amount => _amount;
  String? get interest => _interest;
  String? get day => _day;
  String? get paymentCycle => _paymentCycle;
  String? get duration => _duration;
  String? get interestAmount => _interestAmount;
  String? get processingFee => _processingFee;
  String? get totalAmount => _totalAmount;
  bool? get isManual => _isManual;
  bool? get isExisting => _isExisting;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_reminder != null) {
      map['reminder'] = _reminder?.map((v) => v.toJson()).toList();
    }
    if (_account != null) {
      map['account'] = _account?.toJson();
    }
    if (_fromAccount != null) {
      map['_fromAccount'] = _fromAccount?.toJson();
    }

    map['date'] = _date;
    map['day'] = _day;
    map['loan_id'] = _loanId;
    map['loan_name'] = _loanName;
    map['loan_type'] = _loanType;
    map['amount'] = _amount;
    map['interest'] = _interest;
    map['payment_cycle'] = _paymentCycle;
    map['duration'] = _duration;
    map['interest_amount'] = _interestAmount;
    map['processing_fee'] = _processingFee;
    map['total_amount'] = _totalAmount;
    map['is_manual'] = _isManual;
    map['is_existing'] = _isExisting;
    map['organization'] = _organization;
    return map;
  }

}




/// id : "dd12793d-91f0-411b-823c-2581ba5bf9cb"
/// account_name : "erp"

Account accountFromJson(String str) => Account.fromJson(json.decode(str));
String accountToJson(Account data) => json.encode(data.toJson());
class Account {
  Account({
      String? id, 
      String? accountName,}){
    _id = id;
    _accountName = accountName;
}

  Account.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
  }
  String? _id;
  String? _accountName;
Account copyWith({  String? id,
  String? accountName,
}) => Account(  id: id ?? _id,
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

/// id : "3f9f7bb9-3b6a-487a-8c07-a186d948c40d"
/// reminder_id : 45
/// master_id : 23
/// description : ""
/// amount : "100.00000000"
/// reminder_cycle : "0"
/// date : "2023-10-12"







Reminder reminderFromJson(String str) => Reminder.fromJson(json.decode(str));
String reminderToJson(Reminder data) => json.encode(data.toJson());
class Reminder {
  Reminder({
      String? id, 
      int? reminderId, 
      int? masterId, 
      String? description, 
      String? amount, 
      String? reminderCycle, 
      String? date,}){
    _id = id;
    _reminderId = reminderId;
    _masterId = masterId;
    _description = description;
    _amount = amount;
    _reminderCycle = reminderCycle;
    _date = date;
}

  Reminder.fromJson(dynamic json) {
    _id = json['id']??'';
    _reminderId = json['reminder_id']??'';
    _masterId = json['master_id']??'';
    _description = json['description']??'';
    _amount = json['amount']??'';
    _reminderCycle = json['reminder_cycle']??'';
    _date = json['date']??'';
  }
  String? _id;
  int? _reminderId;
  int? _masterId;
  String? _description;
  String? _amount;
  String? _reminderCycle;
  String? _date;
Reminder copyWith({  String? id,
  int? reminderId,
  int? masterId,
  String? description,
  String? amount,
  String? reminderCycle,
  String? date,
}) => Reminder(  id: id ?? _id,
  reminderId: reminderId ?? _reminderId,
  masterId: masterId ?? _masterId,
  description: description ?? _description,
  amount: amount ?? _amount,
  reminderCycle: reminderCycle ?? _reminderCycle,
  date: date ?? _date,
);
  String? get id => _id;
  int? get reminderId => _reminderId;
  int? get masterId => _masterId;
  String? get description => _description;
  String? get amount => _amount;
  String? get reminderCycle => _reminderCycle;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reminder_id'] = _reminderId;
    map['master_id'] = _masterId;
    map['description'] = _description;
    map['amount'] = _amount;
    map['reminder_cycle'] = _reminderCycle;
    map['date'] = _date;
    return map;
  }

}