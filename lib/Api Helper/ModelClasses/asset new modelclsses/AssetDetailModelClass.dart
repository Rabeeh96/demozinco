import 'dart:convert';
/// StatusCode : 6000
/// summary : {"id":"db684302-7485-4502-bce9-6b3620e72d6d","total_share":"125.00000000","total_value":"2845.00000000","asset_name":"Test","asset_master_id":2,"asset_type":"0","total_income":0,"total_expense":0}
/// data : [{"x-axis":"2023-February","total_income":0,"total_expense":0},{"x-axis":"2023-March","total_income":0,"total_expense":0},{"x-axis":"2023-April","total_income":0,"total_expense":0},{"x-axis":"2023-May","total_income":0,"total_expense":0},{"x-axis":"2023-June","total_income":0,"total_expense":0},{"x-axis":"2023-July","total_income":0,"total_expense":0},{"x-axis":"2023-August","total_income":0,"total_expense":0}]
/// income_account_list : [{"accounts_id":4,"account_name":"Expense","balance":-52233659.0},{"accounts_id":5,"account_name":"Income 3","balance":121114992.0},{"accounts_id":6,"account_name":"Income 4","balance":-2000.0},{"accounts_id":28,"account_name":"Tester","balance":-129180.0},{"accounts_id":30,"account_name":"gg","balance":-11477.0},{"accounts_id":36,"account_name":"Local","balance":-55314.0},{"accounts_id":37,"account_name":"hh","balance":-29853752.0},{"accounts_id":29,"account_name":"di","balance":-780.0},{"accounts_id":2,"account_name":"Rent","balance":-55396.0}]
/// expense_account_list : [{"accounts_id":31,"account_name":"Mi Dlt","balance":16693.0},{"accounts_id":48,"account_name":"Dennis","balance":310177.0},{"accounts_id":42,"account_name":"Stoning","balance":55578177.0},{"accounts_id":39,"account_name":"Changing","balance":206207.0}]

DetailAssetModelClass detailAssetModelClassFromJson(String str) => DetailAssetModelClass.fromJson(json.decode(str));
String detailAssetModelClassToJson(DetailAssetModelClass data) => json.encode(data.toJson());
class DetailAssetModelClass {
  DetailAssetModelClass({
      int? statusCode, 
      Summary? summary, 
      List<Data>? data, 
      List<IncomeAccountList>? incomeAccountList, 
      List<ExpenseAccountList>? expenseAccountList,}){
    _statusCode = statusCode;
    _summary = summary;
    _data = data;
    _incomeAccountList = incomeAccountList;
    _expenseAccountList = expenseAccountList;
}

  DetailAssetModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['income_account_list'] != null) {
      _incomeAccountList = [];
      json['income_account_list'].forEach((v) {
        _incomeAccountList?.add(IncomeAccountList.fromJson(v));
      });
    }
    if (json['expense_account_list'] != null) {
      _expenseAccountList = [];
      json['expense_account_list'].forEach((v) {
        _expenseAccountList?.add(ExpenseAccountList.fromJson(v));
      });
    }
  }
  int? _statusCode;
  Summary? _summary;
  List<Data>? _data;
  List<IncomeAccountList>? _incomeAccountList;
  List<ExpenseAccountList>? _expenseAccountList;
DetailAssetModelClass copyWith({  int? statusCode,
  Summary? summary,
  List<Data>? data,
  List<IncomeAccountList>? incomeAccountList,
  List<ExpenseAccountList>? expenseAccountList,
}) => DetailAssetModelClass(  statusCode: statusCode ?? _statusCode,
  summary: summary ?? _summary,
  data: data ?? _data,
  incomeAccountList: incomeAccountList ?? _incomeAccountList,
  expenseAccountList: expenseAccountList ?? _expenseAccountList,
);
  int? get statusCode => _statusCode;
  Summary? get summary => _summary;
  List<Data>? get data => _data;
  List<IncomeAccountList>? get incomeAccountList => _incomeAccountList;
  List<ExpenseAccountList>? get expenseAccountList => _expenseAccountList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_incomeAccountList != null) {
      map['income_account_list'] = _incomeAccountList?.map((v) => v.toJson()).toList();
    }
    if (_expenseAccountList != null) {
      map['expense_account_list'] = _expenseAccountList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// accounts_id : 31
/// account_name : "Mi Dlt"
/// balance : 16693.0

ExpenseAccountList expenseAccountListFromJson(String str) => ExpenseAccountList.fromJson(json.decode(str));
String expenseAccountListToJson(ExpenseAccountList data) => json.encode(data.toJson());
class ExpenseAccountList {
  ExpenseAccountList({
      int? accountsId, 
      String? accountName, 
      String? balance,}){
    _accountsId = accountsId;
    _accountName = accountName;
    _balance = balance;
}

  ExpenseAccountList.fromJson(dynamic json) {
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
  }
  int? _accountsId;
  String? _accountName;
  String? _balance;
ExpenseAccountList copyWith({  int? accountsId,
  String? accountName,
  String? balance,
}) => ExpenseAccountList(  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
);
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    return map;
  }

}

/// accounts_id : 4
/// account_name : "Expense"
/// balance : -52233659.0

IncomeAccountList incomeAccountListFromJson(String str) => IncomeAccountList.fromJson(json.decode(str));
String incomeAccountListToJson(IncomeAccountList data) => json.encode(data.toJson());
class IncomeAccountList {
  IncomeAccountList({
      int? accountsId, 
      String? accountName, 
      String? balance,}){
    _accountsId = accountsId;
    _accountName = accountName;
    _balance = balance;
}

  IncomeAccountList.fromJson(dynamic json) {
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
  }
  int? _accountsId;
  String? _accountName;
  String? _balance;
IncomeAccountList copyWith({  int? accountsId,
  String? accountName,
  String? balance,
}) => IncomeAccountList(  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
);
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    return map;
  }

}

/// x-axis : "2023-February"
/// total_income : 0
/// total_expense : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? xaxis, 
      String? totalIncome,
      String? totalExpense,}){
    _xaxis = xaxis;
    _totalIncome = totalIncome;
    _totalExpense = totalExpense;
}

  Data.fromJson(dynamic json) {
    _xaxis = json['x-axis'];
    _totalIncome = json['total_income'].toString();
    _totalExpense = json['total_expense'].toString();
  }
  String? _xaxis;
  String? _totalIncome;
  String? _totalExpense;
Data copyWith({  String? xaxis,
  String? totalIncome,
  String? totalExpense,
}) => Data(  xaxis: xaxis ?? _xaxis,
  totalIncome: totalIncome ?? _totalIncome,
  totalExpense: totalExpense ?? _totalExpense,
);
  String? get xaxis => _xaxis;
  String? get totalIncome => _totalIncome;
  String? get totalExpense => _totalExpense;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x-axis'] = _xaxis;
    map['total_income'] = _totalIncome;
    map['total_expense'] = _totalExpense;
    return map;
  }

}

/// id : "db684302-7485-4502-bce9-6b3620e72d6d"
/// total_share : "125.00000000"
/// total_value : "2845.00000000"
/// asset_name : "Test"
/// asset_master_id : 2
/// asset_type : "0"
/// total_income : 0
/// total_expense : 0

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
      String? id, 
      String? totalShare, 
      String? totalValue, 
      String? assetName, 
      int? assetMasterId,
      String? assetType, 
      String? totalIncome,
      String? totalExpense,}){
    _id = id;
    _totalShare = totalShare;
    _totalValue = totalValue;
    _assetName = assetName;
    _assetMasterId = assetMasterId;
    _assetType = assetType;
    _totalIncome = totalIncome;
    _totalExpense = totalExpense;
}

  Summary.fromJson(dynamic json) {
    _id = json['id'];
    _totalShare = json['total_share'];
    _totalValue = json['total_value'];
    _assetName = json['asset_name'];
    _assetMasterId = json['asset_master_id'];
    _assetType = json['asset_type'];
    _totalIncome = json['total_income'].toString();
    _totalExpense = json['total_expense'].toString();
  }
  String? _id;
  String? _totalShare;
  String? _totalValue;
  String? _assetName;
  int? _assetMasterId;
  String? _assetType;
  String? _totalIncome;
  String? _totalExpense;
Summary copyWith({  String? id,
  String? totalShare,
  String? totalValue,
  String? assetName,
  int? assetMasterId,
  String? assetType,
  String? totalIncome,
  String? totalExpense,
}) => Summary(  id: id ?? _id,
  totalShare: totalShare ?? _totalShare,
  totalValue: totalValue ?? _totalValue,
  assetName: assetName ?? _assetName,
  assetMasterId: assetMasterId ?? _assetMasterId,
  assetType: assetType ?? _assetType,
  totalIncome: totalIncome ?? _totalIncome,
  totalExpense: totalExpense ?? _totalExpense,
);
  String? get id => _id;
  String? get totalShare => _totalShare;
  String? get totalValue => _totalValue;
  String? get assetName => _assetName;
  int? get assetMasterId => _assetMasterId;
  String? get assetType => _assetType;
  String? get totalIncome => _totalIncome;
  String? get totalExpense => _totalExpense;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['total_share'] = _totalShare;
    map['total_value'] = _totalValue;
    map['asset_name'] = _assetName;
    map['asset_master_id'] = _assetMasterId;
    map['asset_type'] = _assetType;
    map['total_income'] = _totalIncome;
    map['total_expense'] = _totalExpense;
    return map;
  }

}