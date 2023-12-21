import 'dart:convert';
/// StatusCode : 6000
/// data : {"total_balance":24962282.87,"total_bank_balance":193348.87,"total_cash_balance":24768934.0,"month_expense":3026.0,"total_zakath":3101.0,"total_interest":13866.0,"total_recievable":6415.0,"total_payable":3917.67,"accounts_list":[{"id":"23e53bab-4148-4a41-a953-1ab0f11920c8","account_name":"SBI","balance":-233278.0,"account_type":1},{"id":"de2dbc46-5e08-464f-a9f9-21a06a392ba5","account_name":"Wallet","balance":25581.0,"account_type":2},{"id":"e788dba5-f272-4b2b-b862-d84d9b537100","account_name":"Asd","balance":5550.0,"account_type":2},{"id":"3bc9c3e1-d939-4d6f-9b74-cd2a34c39861","account_name":"Ydf","balance":-590.0,"account_type":2},{"id":"b168d93a-a977-4f20-8da3-deb08a1306a8","account_name":"Union","balance":-369.0,"account_type":2},{"id":"73aa0870-4932-48bf-99c2-b79088d30c68","account_name":"Federal","balance":-200.0,"account_type":2},{"id":"c56b73f8-a270-4874-9863-c2b58e6a524c","account_name":"Boi","balance":265.0,"account_type":2},{"id":"5fa988b1-f3e1-4664-a684-4fbc527304fe","account_name":"Icic","balance":-2000.0,"account_type":2},{"id":"bbf5c4c3-9b9b-4107-9a58-259c9e8928c8","account_name":"My Cas","balance":100000.0,"account_type":2},{"id":"978f778f-588e-41d1-8a56-e8a47d2b5e18","account_name":"Canara","balance":48919.87,"account_type":2},{"id":"e10c19ba-934d-4bdf-bd36-cd7431611665","account_name":"Canarabank","balance":6335.2,"account_type":2},{"id":"e19f3493-644f-415f-aa20-f1a265aa39c2","account_name":"My Cash","balance":25002212.0,"account_type":1},{"id":"a8465188-c9cd-49c7-befc-331f34827eac","account_name":"My Vank","balance":0.0,"account_type":2},{"id":"311df899-c893-401d-a615-6bc3ff732b8b","account_name":"As","balance":9106.8,"account_type":2},{"id":"243171ab-9f3b-4722-bb6f-1f772c644885","account_name":"My Bank","balance":0.0,"account_type":2},{"id":"df8f7cfd-61b2-4370-92cb-fbebcf36e283","account_name":"Tesf","balance":250.0,"account_type":2},{"id":"9d216f5f-fd67-4c52-8a6c-a36af26edf0e","account_name":"Ank","balance":0.0,"account_type":2},{"id":"8425361f-8dae-459f-b41d-9e7be9618ea1","account_name":"Shaheen Bank","balance":500.0,"account_type":2}],"expiry_date":"2023-08-23"}

ModelClassDashboard modelClassDashboardFromJson(String str) => ModelClassDashboard.fromJson(json.decode(str));
String modelClassDashboardToJson(ModelClassDashboard data) => json.encode(data.toJson());
class ModelClassDashboard {
  ModelClassDashboard({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ModelClassDashboard.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
ModelClassDashboard copyWith({  int? statusCode,
  Data? data,
}) => ModelClassDashboard(  statusCode: statusCode ?? _statusCode,
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

/// total_balance : 24962282.87
/// total_bank_balance : 193348.87
/// total_cash_balance : 24768934.0
/// month_expense : 3026.0
/// total_zakath : 3101.0
/// total_interest : 13866.0
/// total_recievable : 6415.0
/// total_payable : 3917.67
/// accounts_list : [{"id":"23e53bab-4148-4a41-a953-1ab0f11920c8","account_name":"SBI","balance":-233278.0,"account_type":1},{"id":"de2dbc46-5e08-464f-a9f9-21a06a392ba5","account_name":"Wallet","balance":25581.0,"account_type":2},{"id":"e788dba5-f272-4b2b-b862-d84d9b537100","account_name":"Asd","balance":5550.0,"account_type":2},{"id":"3bc9c3e1-d939-4d6f-9b74-cd2a34c39861","account_name":"Ydf","balance":-590.0,"account_type":2},{"id":"b168d93a-a977-4f20-8da3-deb08a1306a8","account_name":"Union","balance":-369.0,"account_type":2},{"id":"73aa0870-4932-48bf-99c2-b79088d30c68","account_name":"Federal","balance":-200.0,"account_type":2},{"id":"c56b73f8-a270-4874-9863-c2b58e6a524c","account_name":"Boi","balance":265.0,"account_type":2},{"id":"5fa988b1-f3e1-4664-a684-4fbc527304fe","account_name":"Icic","balance":-2000.0,"account_type":2},{"id":"bbf5c4c3-9b9b-4107-9a58-259c9e8928c8","account_name":"My Cas","balance":100000.0,"account_type":2},{"id":"978f778f-588e-41d1-8a56-e8a47d2b5e18","account_name":"Canara","balance":48919.87,"account_type":2},{"id":"e10c19ba-934d-4bdf-bd36-cd7431611665","account_name":"Canarabank","balance":6335.2,"account_type":2},{"id":"e19f3493-644f-415f-aa20-f1a265aa39c2","account_name":"My Cash","balance":25002212.0,"account_type":1},{"id":"a8465188-c9cd-49c7-befc-331f34827eac","account_name":"My Vank","balance":0.0,"account_type":2},{"id":"311df899-c893-401d-a615-6bc3ff732b8b","account_name":"As","balance":9106.8,"account_type":2},{"id":"243171ab-9f3b-4722-bb6f-1f772c644885","account_name":"My Bank","balance":0.0,"account_type":2},{"id":"df8f7cfd-61b2-4370-92cb-fbebcf36e283","account_name":"Tesf","balance":250.0,"account_type":2},{"id":"9d216f5f-fd67-4c52-8a6c-a36af26edf0e","account_name":"Ank","balance":0.0,"account_type":2},{"id":"8425361f-8dae-459f-b41d-9e7be9618ea1","account_name":"Shaheen Bank","balance":500.0,"account_type":2}]
/// expiry_date : "2023-08-23"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? totalBalance,
      String? totalBankBalance,
      String? totalCashBalance,
      String? monthExpense,
      String? totalZakath,
      String? totalInterest,
      String? totalRecievable,
      String? totalPayable,
      List<AccountsList>? accountsList, 
      String? expiryDate,}){
    _totalBalance = totalBalance;
    _totalBankBalance = totalBankBalance;
    _totalCashBalance = totalCashBalance;
    _monthExpense = monthExpense;
    _totalZakath = totalZakath;
    _totalInterest = totalInterest;
    _totalRecievable = totalRecievable;
    _totalPayable = totalPayable;
    _accountsList = accountsList;
    _expiryDate = expiryDate;
}

  Data.fromJson(dynamic json) {
    _totalBalance = json['total_balance'].toString();
    _totalBankBalance = json['total_bank_balance'].toString();
    _totalCashBalance = json['total_cash_balance'].toString();
    _monthExpense = json['month_expense'].toString();
    _totalZakath = json['total_zakath'].toString();
    _totalInterest = json['total_interest'].toString();
    _totalRecievable = json['total_recievable'].toString();
    _totalPayable = json['total_payable'].toString();
    if (json['accounts_list'] != null) {
      _accountsList = [];
      json['accounts_list'].forEach((v) {
        _accountsList?.add(AccountsList.fromJson(v));
      });
    }
    _expiryDate = json['expiry_date'];
  }
  String? _totalBalance;
  String? _totalBankBalance;
  String? _totalCashBalance;
  String? _monthExpense;
  String? _totalZakath;
  String? _totalInterest;
  String? _totalRecievable;
  String? _totalPayable;
  List<AccountsList>? _accountsList;
  String? _expiryDate;
Data copyWith({  String? totalBalance,
  String? totalBankBalance,
  String? totalCashBalance,
  String? monthExpense,
  String? totalZakath,
  String? totalInterest,
  String? totalRecievable,
  String? totalPayable,
  List<AccountsList>? accountsList,
  String? expiryDate,
}) => Data(  totalBalance: totalBalance ?? _totalBalance,
  totalBankBalance: totalBankBalance ?? _totalBankBalance,
  totalCashBalance: totalCashBalance ?? _totalCashBalance,
  monthExpense: monthExpense ?? _monthExpense,
  totalZakath: totalZakath ?? _totalZakath,
  totalInterest: totalInterest ?? _totalInterest,
  totalRecievable: totalRecievable ?? _totalRecievable,
  totalPayable: totalPayable ?? _totalPayable,
  accountsList: accountsList ?? _accountsList,
  expiryDate: expiryDate ?? _expiryDate,
);
  String? get totalBalance => _totalBalance;
  String? get totalBankBalance => _totalBankBalance;
  String? get totalCashBalance => _totalCashBalance;
  String? get monthExpense => _monthExpense;
  String? get totalZakath => _totalZakath;
  String? get totalInterest => _totalInterest;
  String? get totalRecievable => _totalRecievable;
  String? get totalPayable => _totalPayable;
  List<AccountsList>? get accountsList => _accountsList;
  String? get expiryDate => _expiryDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_balance'] = _totalBalance;
    map['total_bank_balance'] = _totalBankBalance;
    map['total_cash_balance'] = _totalCashBalance;
    map['month_expense'] = _monthExpense;
    map['total_zakath'] = _totalZakath;
    map['total_interest'] = _totalInterest;
    map['total_recievable'] = _totalRecievable;
    map['total_payable'] = _totalPayable;
    if (_accountsList != null) {
      map['accounts_list'] = _accountsList?.map((v) => v.toJson()).toList();
    }
    map['expiry_date'] = _expiryDate;
    return map;
  }

}

/// id : "23e53bab-4148-4a41-a953-1ab0f11920c8"
/// account_name : "SBI"
/// balance : -233278.0
/// account_type : 1

AccountsList accountsListFromJson(String str) => AccountsList.fromJson(json.decode(str));
String accountsListToJson(AccountsList data) => json.encode(data.toJson());
class AccountsList {
  AccountsList({
      String? id, 
      String? accountName, 
      String? balance,
      String? accountType,}){
    _id = id;
    _accountName = accountName;
    _balance = balance;
    _accountType = accountType;
}

  AccountsList.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
    _accountType = json['account_type'].toString();
  }
  String? _id;
  String? _accountName;
  String? _balance;
  String? _accountType;
AccountsList copyWith({  String? id,
  String? accountName,
  String? balance,
  String? accountType,
}) => AccountsList(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
  accountType: accountType ?? _accountType,
);
  String? get id => _id;
  String? get accountName => _accountName;
  String? get balance => _balance;
  String? get accountType => _accountType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    map['account_type'] = _accountType;
    return map;
  }

}