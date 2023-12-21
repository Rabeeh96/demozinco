import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"f4eeeca0-f201-4539-9441-e28e13e7bd49","country":{"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_name":"India","currency_name":"Rupee","currency_simbol":"Rs","country_code":"INR"},"created_user_id":1,"updated_user_id":null,"created_date":"2023-05-22T08:43:54.920729Z","updated_date":"2023-05-22T08:43:54.920769Z","action":"A","is_delete":false,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailCountryModelClass detailCountryModelClassFromJson(String str) => DetailCountryModelClass.fromJson(json.decode(str));
String detailCountryModelClassToJson(DetailCountryModelClass data) => json.encode(data.toJson());
class DetailCountryModelClass {
  DetailCountryModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailCountryModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailCountryModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailCountryModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "f4eeeca0-f201-4539-9441-e28e13e7bd49"
/// country : {"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_name":"India","currency_name":"Rupee","currency_simbol":"Rs","country_code":"INR"}
/// created_user_id : 1
/// updated_user_id : null
/// created_date : "2023-05-22T08:43:54.920729Z"
/// updated_date : "2023-05-22T08:43:54.920769Z"
/// action : "A"
/// is_delete : false
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Country? country, 
      int? createdUserId, 
      dynamic updatedUserId,
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      String? organization,}){
    _id = id;
    _country = country;
    _createdUserId = createdUserId;

    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
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
    _organization = json['organization'];
  }
  String? _id;
  Country? _country;
  int? _createdUserId;

  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  String? _organization;
Data copyWith({  String? id,
  Country? country,
  int? createdUserId,

  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  String? organization,
}) => Data(  id: id ?? _id,
  country: country ?? _country,
  createdUserId: createdUserId ?? _createdUserId,

  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  organization: organization ?? _organization,
);
  String? get id => _id;
  Country? get country => _country;
  int? get createdUserId => _createdUserId;

  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
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
    map['organization'] = _organization;
    return map;
  }

}

/// id : "9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"
/// country_name : "India"
/// currency_name : "Rupee"
/// currency_simbol : "Rs"
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