import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"521367ac-a0a4-4a0f-8407-e5b51868689a","country":{"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_name":"India","currency_name":"Rupees","currency_simbol":"₹","country_code":"INR"},"action":"A","is_delete":false,"is_default":true,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"},null]

ListCountryModelClass listCountryModelClassFromJson(String str) => ListCountryModelClass.fromJson(json.decode(str));
String listCountryModelClassToJson(ListCountryModelClass data) => json.encode(data.toJson());
class ListCountryModelClass {
  ListCountryModelClass({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  ListCountryModelClass.fromJson(dynamic json) {
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
ListCountryModelClass copyWith({  int? statusCode,
  List<Data>? data,
}) => ListCountryModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "521367ac-a0a4-4a0f-8407-e5b51868689a"
/// country : {"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_name":"India","currency_name":"Rupees","currency_simbol":"₹","country_code":"INR"}
/// action : "A"
/// is_delete : false
/// is_default : true
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Country? country, 
      String? action, 
      bool? isDelete, 
      bool? isDefault, 
      String? organization,}){
    _id = id;
    _country = country;
    _action = action;
    _isDelete = isDelete;
    _isDefault = isDefault;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _action = json['action'];
    _isDelete = json['is_delete'];
    _isDefault = json['is_default'];
    _organization = json['organization'];
  }
  String? _id;
  Country? _country;
  String? _action;
  bool? _isDelete;
  bool? _isDefault;
  String? _organization;
Data copyWith({  String? id,
  Country? country,
  String? action,
  bool? isDelete,
  bool? isDefault,
  String? organization,
}) => Data(  id: id ?? _id,
  country: country ?? _country,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  isDefault: isDefault ?? _isDefault,
  organization: organization ?? _organization,
);
  String? get id => _id;
  Country? get country => _country;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  bool? get isDefault => _isDefault;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['is_default'] = _isDefault;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"
/// country_name : "India"
/// currency_name : "Rupees"
/// currency_simbol : "₹"
/// country_code : "INR"

Country countryFromJson(String str) => Country.fromJson(json.decode(str));
String countryToJson(Country data) => json.encode(data.toJson());
class Country {
  Country({
      String? id, 
      String? countryName, 
      String? currencyName, 
      String? currencySimbol, 
      String? countryCode,}){
    _id = id;
    _countryName = countryName;
    _currencyName = currencyName;
    _currencySimbol = currencySimbol;
    _countryCode = countryCode;
}

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
    _currencySimbol = json['currency_simbol'];
    _countryCode = json['country_code'];
  }
  String? _id;
  String? _countryName;
  String? _currencyName;
  String? _currencySimbol;
  String? _countryCode;
Country copyWith({  String? id,
  String? countryName,
  String? currencyName,
  String? currencySimbol,
  String? countryCode,
}) => Country(  id: id ?? _id,
  countryName: countryName ?? _countryName,
  currencyName: currencyName ?? _currencyName,
  currencySimbol: currencySimbol ?? _currencySimbol,
  countryCode: countryCode ?? _countryCode,
);
  String? get id => _id;
  String? get countryName => _countryName;
  String? get currencyName => _currencyName;
  String? get currencySimbol => _currencySimbol;
  String? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country_name'] = _countryName;
    map['currency_name'] = _currencyName;
    map['currency_simbol'] = _currencySimbol;
    map['country_code'] = _countryCode;
    return map;
  }

}