import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"b42e3abf-7752-4d52-bf3c-0c2b8ec162f3","country":{"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_code":"INR","country_name":"India","currency_name":"Rupee"},"created_user_id":1,"created_date":"2023-05-24T05:04:39.994456Z","updated_date":"2023-05-24T05:04:39.994477Z","action":"A","is_delete":false,"accounts_id":18,"account_name":"nsnsns","is_owns_you":false,"amount":null,"opening_balance":"9494.00000000","as_on_date":"2023-05-24","account_type":"2","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailAccountModelClass detailAccountModelClassFromJson(String str) => DetailAccountModelClass.fromJson(json.decode(str));
String detailAccountModelClassToJson(DetailAccountModelClass data) => json.encode(data.toJson());
class DetailAccountModelClass {
  DetailAccountModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailAccountModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailAccountModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailAccountModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "b42e3abf-7752-4d52-bf3c-0c2b8ec162f3"
/// country : {"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_code":"INR","country_name":"India","currency_name":"Rupee"}
/// created_user_id : 1
/// created_date : "2023-05-24T05:04:39.994456Z"
/// updated_date : "2023-05-24T05:04:39.994477Z"
/// action : "A"
/// is_delete : false
/// accounts_id : 18
/// account_name : "nsnsns"
/// is_owns_you : false
/// amount : null
/// opening_balance : "9494.00000000"
/// as_on_date : "2023-05-24"
/// account_type : "2"
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Country? country, 
      int? createdUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      int? accountsId, 
      String? accountName, 
      bool? isOwnsYou, 

      String? openingBalance, 
      String? asOnDate, 
      String? accountType, 
      String? organization,}){
    _id = id;
    _country = country;
    _createdUserId = createdUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
    _accountsId = accountsId;
    _accountName = accountName;
    _isOwnsYou = isOwnsYou;

    _openingBalance = openingBalance;
    _asOnDate = asOnDate;
    _accountType = accountType;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _createdUserId = json['created_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _isOwnsYou = json['is_owns_you'];

    _openingBalance = json['opening_balance'];
    _asOnDate = json['as_on_date'];
    _accountType = json['account_type'];
    _organization = json['organization'];
  }
  String? _id;
  Country? _country;
  int? _createdUserId;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  int? _accountsId;
  String? _accountName;
  bool? _isOwnsYou;

  String? _openingBalance;
  String? _asOnDate;
  String? _accountType;
  String? _organization;
Data copyWith({  String? id,
  Country? country,
  int? createdUserId,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  int? accountsId,
  String? accountName,
  bool? isOwnsYou,

  String? openingBalance,
  String? asOnDate,
  String? accountType,
  String? organization,
}) => Data(  id: id ?? _id,
  country: country ?? _country,
  createdUserId: createdUserId ?? _createdUserId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  isOwnsYou: isOwnsYou ?? _isOwnsYou,

  openingBalance: openingBalance ?? _openingBalance,
  asOnDate: asOnDate ?? _asOnDate,
  accountType: accountType ?? _accountType,
  organization: organization ?? _organization,
);
  String? get id => _id;
  Country? get country => _country;
  int? get createdUserId => _createdUserId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  bool? get isOwnsYou => _isOwnsYou;

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
    map['created_user_id'] = _createdUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['is_owns_you'] = _isOwnsYou;

    map['opening_balance'] = _openingBalance;
    map['as_on_date'] = _asOnDate;
    map['account_type'] = _accountType;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"
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
      String? currencyName,}){
    _id = id;
    _countryCode = countryCode;
    _countryName = countryName;
    _currencyName = currencyName;
}

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currencyName;
Country copyWith({  String? id,
  String? countryCode,
  String? countryName,
  String? currencyName,
}) => Country(  id: id ?? _id,
  countryCode: countryCode ?? _countryCode,
  countryName: countryName ?? _countryName,
  currencyName: currencyName ?? _currencyName,
);
  String? get id => _id;
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get currencyName => _currencyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country_code'] = _countryCode;
    map['country_name'] = _countryName;
    map['currency_name'] = _currencyName;
    return map;
  }

}