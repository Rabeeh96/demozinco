import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"0f16d9cb-73a4-4533-8322-6d6be2fa66b5","account":{"id":"064523e7-dd69-49fb-8827-a4a034161517","account_name":"Rabeeh loan"},"from_account":{"id":"064523e7-dd69-49fb-8827-a4a034161517","account_name":"Bank"},"date":"2023-06-28","loan_id":2,"loan_name":"Rabeeh loan","loan_type":"0","amount":"10000.00000000","interest":"1.00000000","payment_cycle":"1","duration":"15","interest_amount":"100.00000000","processing_fee":"0.00000000","total_amount":"10100.00000000","day":"Monday, 1, January","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}
/// shedule : [{"id":"30432616-e4e2-454e-b4fa-db6dacc215a9","date":"2023-07-03","amount":673.33,"status":false}]
/// history : [{"id":"54f2ccde-5210-4685-857b-a72ac1a4092d","date":"2023-10-09","amount":673.33,"status":false}]

LoanViewModelClass loanViewModelClassFromJson(String str) => LoanViewModelClass.fromJson(json.decode(str));
String loanViewModelClassToJson(LoanViewModelClass data) => json.encode(data.toJson());
class LoanViewModelClass {
  LoanViewModelClass({
      int? statusCode, 
      Data? data, 
      List<Shedule>? shedule, 
      List<History>? history,}){
    _statusCode = statusCode;
    _data = data;
    _shedule = shedule;
    _history = history;
}

  LoanViewModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['schedule'] != null) {
      _shedule = [];
      json['schedule'].forEach((v) {
        _shedule?.add(Shedule.fromJson(v));
      });
    }
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
  }
  int? _statusCode;
  Data? _data;
  List<Shedule>? _shedule;
  List<History>? _history;
LoanViewModelClass copyWith({  int? statusCode,
  Data? data,
  List<Shedule>? shedule,
  List<History>? history,
}) => LoanViewModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  shedule: shedule ?? _shedule,
  history: history ?? _history,
);
  int? get statusCode => _statusCode;
  Data? get data => _data;
  List<Shedule>? get shedule => _shedule;
  List<History>? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_shedule != null) {
      map['schedule'] = _shedule?.map((v) => v.toJson()).toList();
    }
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "54f2ccde-5210-4685-857b-a72ac1a4092d"
/// date : "2023-10-09"
/// amount : 673.33
/// status : false
// "time": "11:48:00",
// "amount": 8500.0,
// "from_account": "Accounts object (c02fd7dc-f543-4ad1-a10b-45094e6f71c0)",
// "from_account_name": "HDFC Bank Calicut",





History historyFromJson(String str) => History.fromJson(json.decode(str));
String historyToJson(History data) => json.encode(data.toJson());
class History {
  History({
      String? id, 
      String? date,
      String? from_account_name,
      String? amount,
      String? time,
      bool? status,}){
    _id = id;
    _date = date;
    _amount = amount;
    _time = time;
    _from_account_name = from_account_name;
    _status = status;
}

  History.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _time = json['time'];
    _amount = json['amount'].toString();
    _status = json['status'];
    _from_account_name = json['from_account_name'];
  }
  String? _id;
  String? _date;
  String? _amount;
  String? _time;
  String? _from_account_name;
  bool? _status;
History copyWith({  String? id,
  String? date,
  String? amount,
  String? from_account_name,
  String? time,
  bool? status,
}) => History(  id: id ?? _id,
  date: date ?? _date,
  amount: amount ?? _amount,
  time: amount ?? _time,
  from_account_name: from_account_name ?? _from_account_name,
  status: status ?? _status,
);
  String? get id => _id;
  String? get date => _date;
  String? get amount => _amount;
  String? get time => _time;
  String? get from_account_name => _from_account_name;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['amount'] = _amount;
    map['time'] = _time;
    map['from_account_name'] = _from_account_name;
    map['status'] = _status;
    return map;
  }

}

/// id : "30432616-e4e2-454e-b4fa-db6dacc215a9"
/// date : "2023-07-03"
/// amount : 673.33
/// status : false

Shedule sheduleFromJson(String str) => Shedule.fromJson(json.decode(str));
String sheduleToJson(Shedule data) => json.encode(data.toJson());
class Shedule {
  Shedule({
      String? id, 
      String? date,
     String? amount,
     String? add_amount,
     String? down_payment,
      bool? status, bool? is_initial,}){
    _id = id;
    _date = date;
    _amount = amount;
    _status = status;
    _add_amount = add_amount;
    _add_amount = down_payment;
    _is_initial = is_initial;
}

  Shedule.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _amount = json['amount'].toString();
    _status = json['status'];
    _is_initial = json['is_initial'];
    _add_amount = json['add_amount'].toString();;
    _down_payment = json['down_payment'].toString();;
  }
  String? _id;
  String? _date;
  String? _amount;
  String? _add_amount;
  String? _down_payment;
  bool? _status;
  bool? _is_initial;
Shedule copyWith({  String? id,
  String? date,
  String? amount,
  String? add_amount,
  String? down_payment,
  bool? is_initial,
  bool? status,
}) => Shedule(  id: id ?? _id,
  date: date ?? _date,
  add_amount: add_amount ?? _add_amount,
  is_initial: is_initial ?? _is_initial,
  amount: amount ?? _amount,
  down_payment: down_payment ?? _down_payment,
  status: status ?? _status,
);
  String? get id => _id;
  String? get date => _date;
  String? get amount => _amount;
  String? get add_amount => _add_amount;
  bool? get is_initial => _is_initial;
  String? get down_payment => _down_payment;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['amount'] = _amount;
    map['status'] = _status;
    map['add_amount'] = _add_amount;
    map['is_initial'] = _is_initial;
    map['down_payment'] = _down_payment;
    return map;
  }

}

/// id : "0f16d9cb-73a4-4533-8322-6d6be2fa66b5"
/// account : {"id":"064523e7-dd69-49fb-8827-a4a034161517","account_name":"Rabeeh loan"}
/// from_account : {"id":"064523e7-dd69-49fb-8827-a4a034161517","account_name":"Bank"}
/// date : "2023-06-28"
/// loan_id : 2
/// loan_name : "Rabeeh loan"
/// loan_type : "0"
/// amount : "10000.00000000"
/// interest : "1.00000000"
/// payment_cycle : "1"
/// duration : "15"
/// interest_amount : "100.00000000"
/// processing_fee : "0.00000000"
/// total_amount : "10100.00000000"
/// day : "Monday, 1, January"
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());


class Data {
  Data({
    this.id,
    this.totalInterest,
    this.nextPayment,
    this.totalAmount,
    this.pendingEmi,
    this.date,
    this.loanId,
    this.loanName,
    this.paymentType,
    this.loanAmount,
    this.interest,
    this.duration,
    this.is_initial_payment,
    this.paymentDate,
    this.processingFee,
    this.isFeeIncludeLoan,
    this.loan_status,
    this.isFeeIncludeEmi,
    this.isPurchase,
    this.isExisting,
    this.downPayment,
    this.amount_paid,
    this.outstanding_amount,
    this.interest_paid,
    this.organization,
    this.account,
    this.toAccount,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    totalInterest = json['total_interest'].toString();
    nextPayment = json['next_payment'].toString();
    totalAmount = json['total_amount'].toString();
    pendingEmi = json['pending_emi'].toString();
    outstanding_amount = json['outstanding_amount'].toString();
    loan_status = json['loan_status'].toString();
    date = json['date']??"";
    loanId = json['loan_id']??"";
    loanName = json['loan_name']??"";
    paymentType = json['payment_type']??"";
    loanAmount = json['loan_amount']??"";
    interest = json['interest'].toString();
    duration = json['duration'].toString();
    paymentDate = json['payment_date']??"";
    processingFee = json['processing_fee'].toString();
    isFeeIncludeLoan = json['is_fee_include_loan']??"";
    isFeeIncludeEmi = json['is_fee_include_emi']??"";
    isPurchase = json['is_purchase']??"";
    isExisting = json['is_existing']??"";
    downPayment = json['down_payment']??"";
    is_initial_payment = json['is_initial_payment']??false;
    organization = json['organization']??"";
    amount_paid = json['amount_paid']??"";
    interest_paid = json['interest_paid']??"";
    account = json['account']??"";
    toAccount = json['to_account']??"";
  }
  String ? id;
  String ? totalInterest;
  String ? nextPayment;
  String ? totalAmount;
  String ? pendingEmi;
  String ? outstanding_amount;
  String ? date;
  int ? loanId;
  String ? loanName;
  String ? paymentType;
  String ? loanAmount;
  bool ? is_initial_payment;
  String ? interest;
  String ? duration;
  String ? paymentDate;
  String ? processingFee;
  String ? loan_status;
  bool ? isFeeIncludeLoan;
  bool ? isFeeIncludeEmi;
  bool ? isPurchase;
  bool ? isExisting;
  String ? downPayment;
  String ? amount_paid;
  String ? interest_paid;
  String ? organization;
  String ? account;
  String ? toAccount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total_interest'] = totalInterest;
    map['next_payment'] = nextPayment;
    map['total_amount'] = totalAmount;
    map['pending_emi'] = pendingEmi;
    map['pending_emi'] = is_initial_payment;
    map['date'] = date;
    map['loan_id'] = loanId;
    map['loan_name'] = loanName;
    map['payment_type'] = paymentType;
    map['loan_amount'] = loanAmount;
    map['interest'] = interest;
    map['duration'] = duration;
    map['payment_date'] = paymentDate;
    map['outstanding_amount'] = outstanding_amount;
    map['processing_fee'] = processingFee;
    map['is_fee_include_loan'] = isFeeIncludeLoan;
    map['is_fee_include_emi'] = isFeeIncludeEmi;
    map['is_purchase'] = isPurchase;
    map['is_existing'] = isExisting;
    map['down_payment'] = downPayment;
    map['loan_status'] = loan_status;
    map['organization'] = organization;
    map['account'] = account;
    map['amount_paid'] = toAccount;
    map['interest_paid'] = toAccount;
    map['to_account'] = toAccount;
    return map;
  }

}

/// id : "064523e7-dd69-49fb-8827-a4a034161517"
/// account_name : "Bank"

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

/// id : "064523e7-dd69-49fb-8827-a4a034161517"
/// account_name : "Rabeeh loan"

Account accountFromJson(String str) => Account.fromJson(json.decode(str));
String accountToJson(Account data) => json.encode(data.toJson());
class Account {
  Account({
      String? id, 
      String? balance,
      String? accountName,}){
    _id = id;
    _accountName = accountName;
    _balance = balance;
}

  Account.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
  }
  String? _id;
  String? _accountName;
  String? _balance;
Account copyWith({  String? id,
  String? accountName,
  String? balance,
}) => Account(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
);
  String? get id => _id;
  String? get accountName => _accountName;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    return map;
  }

}