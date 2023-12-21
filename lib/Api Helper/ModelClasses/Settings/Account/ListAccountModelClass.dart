import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"f4af7e84-03ed-47e3-a59b-48f7ef723e27","country":{"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"},"action":"A","is_delete":false,"accounts_id":49,"account_name":"Updated Acdcountffffgfg","amount":"200.00000000","opening_balance":"200.00000000","as_on_date":"","account_type":"0","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"},null]
/// count : 8
/// current_page : 1
/// total_pages : 1
/// next_page : null
/// previous_page : null

ListAccountModelClass listAccountModelClassFromJson(String str) => ListAccountModelClass.fromJson(json.decode(str));
String listAccountModelClassToJson(ListAccountModelClass data) => json.encode(data.toJson());
class ListAccountModelClass {
  ListAccountModelClass({
      int? statusCode, 
      List<Data>? data, 
      int? count, 
      int? currentPage, 
      int? totalPages, 
      dynamic nextPage, 
      dynamic previousPage,}){
    _statusCode = statusCode;
    _data = data;
    _count = count;
    _currentPage = currentPage;
    _totalPages = totalPages;
    _nextPage = nextPage;
    _previousPage = previousPage;
}

  ListAccountModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _count = json['count'];
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _nextPage = json['next_page'];
    _previousPage = json['previous_page'];
  }
  int? _statusCode;
  List<Data>? _data;
  int? _count;
  int? _currentPage;
  int? _totalPages;
  dynamic _nextPage;
  dynamic _previousPage;
ListAccountModelClass copyWith({  int? statusCode,
  List<Data>? data,
  int? count,
  int? currentPage,
  int? totalPages,
  dynamic nextPage,
  dynamic previousPage,
}) => ListAccountModelClass(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  count: count ?? _count,
  currentPage: currentPage ?? _currentPage,
  totalPages: totalPages ?? _totalPages,
  nextPage: nextPage ?? _nextPage,
  previousPage: previousPage ?? _previousPage,
);
  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
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
    map['count'] = _count;
    map['current_page'] = _currentPage;
    map['total_pages'] = _totalPages;
    map['next_page'] = _nextPage;
    map['previous_page'] = _previousPage;
    return map;
  }

}

/// id : "f4af7e84-03ed-47e3-a59b-48f7ef723e27"
/// country : {"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"}
/// action : "A"
/// is_delete : false
/// accounts_id : 49
/// account_name : "Updated Acdcountffffgfg"
/// amount : "200.00000000"
/// opening_balance : "200.00000000"
/// as_on_date : ""
/// account_type : "0"
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Country? country, 
      String? action, 
      bool? isDelete, 
      int? accountsId, 
      String? accountName, 
      String? amount, 
      String? openingBalance, 
      String? asOnDate, 
      String? accountType, 
      String? organization,}){
    _id = id;
    _country = country;
    _action = action;
    _isDelete = isDelete;
    _accountsId = accountsId;
    _accountName = accountName;
    _amount = amount;
    _openingBalance = openingBalance;
    _asOnDate = asOnDate;
    _accountType = accountType;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _action = json['action'];
    _isDelete = json['is_delete'];
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _amount = json['amount']?? "";
    _openingBalance = json['opening_balance'];
    _asOnDate = json['as_on_date'] ?? "";
    _accountType = json['account_type'];
    _organization = json['organization'];
  }
  String? _id;
  Country? _country;
  String? _action;
  bool? _isDelete;
  int? _accountsId;
  String? _accountName;
  String? _amount;
  String? _openingBalance;
  String? _asOnDate;
  String? _accountType;
  String? _organization;
Data copyWith({  String? id,
  Country? country,
  String? action,
  bool? isDelete,
  int? accountsId,
  String? accountName,
  String? amount,
  String? openingBalance,
  String? asOnDate,
  String? accountType,
  String? organization,
}) => Data(  id: id ?? _id,
  country: country ?? _country,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
  openingBalance: openingBalance ?? _openingBalance,
  asOnDate: asOnDate ?? _asOnDate,
  accountType: accountType ?? _accountType,
  organization: organization ?? _organization,
);
  String? get id => _id;
  Country? get country => _country;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get amount => _amount;
  String? get openingBalance => _openingBalance;
  String? get asOnDate => _asOnDate;
  String? get accountType => _accountType;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    map['opening_balance'] = _openingBalance;
    map['as_on_date'] = _asOnDate;
    map['account_type'] = _accountType;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupee"

Country countryFromJson(String str) => Country.fromJson(json.decode(str));
String countryToJson(Country data) => json.encode(data.toJson());
class Country {
  Country({
      String? id, 
      String? countryCode, 
      String? countryName, 
      String? currencyName,
      String? currency_simbol,
  }){
    _id = id;
    _countryCode = countryCode;
    _countryName = countryName;
    _currencyName = currencyName;
    _currency_simbol = currency_simbol;
}

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _currency_simbol = json['currency_simbol'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currency_simbol;
  String? _currencyName;
Country copyWith({  String? id,
  String? countryCode,
  String? countryName,
  String? currency_simbol,
  String? currencyName,
}) => Country(  id: id ?? _id,
  countryCode: countryCode ?? _countryCode,
  currency_simbol: currency_simbol ?? _currency_simbol,
  countryName: countryName ?? _countryName,
  currencyName: currencyName ?? _currencyName,
);
  String? get id => _id;
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get currency_simbol => _currency_simbol;
  String? get currencyName => _currencyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country_code'] = _countryCode;
    map['currency_simbol'] = _currency_simbol;
    map['country_name'] = _countryName;
    map['currency_name'] = _currencyName;
    return map;
  }

}