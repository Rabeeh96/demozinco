import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"ae7c8284-b7af-4ab5-9a3f-2915b563142e","organization":"85705232-6fba-46ba-93e7-e560145ab0e0","accounts_id":10,"account_name":"Rent home","balance":0,"opening_balance":"0.00000000","as_on_date":"2023-08-08"},null]
/// summary : {"total":0,"this_month":0}
/// count : 9
/// current_page : 1
/// total_pages : 1
/// next_page : null
/// previous_page : null

ModelClassIncome modelClassIncomeFromJson(String str) => ModelClassIncome.fromJson(json.decode(str));
String modelClassIncomeToJson(ModelClassIncome data) => json.encode(data.toJson());
class ModelClassIncome {
  ModelClassIncome({
      int? statusCode, 
      List<Data>? data, 
      Summary? summary, 
      int? count, 
      int? currentPage, 
      int? totalPages, 
      dynamic nextPage, 
      dynamic previousPage,}){
    _statusCode = statusCode;
    _data = data;
    _summary = summary;
    _count = count;
    _currentPage = currentPage;
    _totalPages = totalPages;
    _nextPage = nextPage;
    _previousPage = previousPage;
}

  ModelClassIncome.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    _count = json['count'];
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _nextPage = json['next_page'];
    _previousPage = json['previous_page'];
  }
  int? _statusCode;
  List<Data>? _data;
  Summary? _summary;
  int? _count;
  int? _currentPage;
  int? _totalPages;
  dynamic _nextPage;
  dynamic _previousPage;
ModelClassIncome copyWith({  int? statusCode,
  List<Data>? data,
  Summary? summary,
  int? count,
  int? currentPage,
  int? totalPages,
  dynamic nextPage,
  dynamic previousPage,
}) => ModelClassIncome(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  summary: summary ?? _summary,
  count: count ?? _count,
  currentPage: currentPage ?? _currentPage,
  totalPages: totalPages ?? _totalPages,
  nextPage: nextPage ?? _nextPage,
  previousPage: previousPage ?? _previousPage,
);
  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  Summary? get summary => _summary;
  int? get count => _count;
  int? get currentPage => _currentPage;
  int? get totalPages => _totalPages;
  dynamic get nextPage => _nextPage;
  dynamic get previousPage => _previousPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    map['count'] = _count;
    map['current_page'] = _currentPage;
    map['total_pages'] = _totalPages;
    map['next_page'] = _nextPage;
    map['previous_page'] = _previousPage;
    return map;
  }

}

/// total : 0
/// this_month : 0

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
      String? total,
      String? thisMonth,}){
    _total = total;
    _thisMonth = thisMonth;
}

  Summary.fromJson(dynamic json) {
    _total = json['total'].toString();
    _thisMonth = json['this_month'].toString();
  }
  String? _total;
  String? _thisMonth;
Summary copyWith({  String? total,
  String? thisMonth,
}) => Summary(  total: total ?? _total,
  thisMonth: thisMonth ?? _thisMonth,
);
  String? get total => _total;
  String? get thisMonth => _thisMonth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['this_month'] = _thisMonth;
    return map;
  }

}

/// id : "ae7c8284-b7af-4ab5-9a3f-2915b563142e"
/// organization : "85705232-6fba-46ba-93e7-e560145ab0e0"
/// accounts_id : 10
/// account_name : "Rent home"
/// balance : 0
/// opening_balance : "0.00000000"
/// as_on_date : "2023-08-08"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      int? accountsId,
      String? accountName, 
      String? balance,
      String? openingBalance, 
      String? asOnDate,}){
    _id = id;
    _accountsId = accountsId;
    _accountName = accountName;
    _balance = balance;
    _openingBalance = openingBalance;
    _asOnDate = asOnDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
    _openingBalance = json['opening_balance'];
    _asOnDate = json['as_on_date'];
  }
  String? _id;
  int? _accountsId;
  String? _accountName;
  String? _balance;
  String? _openingBalance;
  String? _asOnDate;
Data copyWith({  String? id,
  String? organization,
  int? accountsId,
  String? accountName,
  String? balance,
  String? openingBalance,
  String? asOnDate,
}) => Data(  id: id ?? _id,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
  openingBalance: openingBalance ?? _openingBalance,
  asOnDate: asOnDate ?? _asOnDate,
);
  String? get id => _id;
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get balance => _balance;
  String? get openingBalance => _openingBalance;
  String? get asOnDate => _asOnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    map['opening_balance'] = _openingBalance;
    map['as_on_date'] = _asOnDate;
    return map;
  }

}