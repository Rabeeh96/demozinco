import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7","country_code":"INR","country_name":"India","currency_name":"Rupee","currency_simbol":"Rs"}]

DefaultCountryModelClass defaultCountryModelClassFromJson(String str) => DefaultCountryModelClass.fromJson(json.decode(str));
String defaultCountryModelClassToJson(DefaultCountryModelClass data) => json.encode(data.toJson());
class DefaultCountryModelClass {
  DefaultCountryModelClass({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DefaultCountryModelClass.fromJson(dynamic json) {
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
DefaultCountryModelClass copyWith({  int? statusCode,
  List<Data>? data,
}) => DefaultCountryModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupee"
/// currency_simbol : "Rs"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? countryCode, 
      String? countryName, 
      String? currencyName, 
      String? currencySimbol,}){
    _id = id;
    _countryCode = countryCode;
    _countryName = countryName;
    _currencyName = currencyName;
    _currencySimbol = currencySimbol;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
    _currencySimbol = json['currency_simbol'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currencyName;
  String? _currencySimbol;
Data copyWith({  String? id,
  String? countryCode,
  String? countryName,
  String? currencyName,
  String? currencySimbol,
}) => Data(  id: id ?? _id,
  countryCode: countryCode ?? _countryCode,
  countryName: countryName ?? _countryName,
  currencyName: currencyName ?? _currencyName,
  currencySimbol: currencySimbol ?? _currencySimbol,
);
  String? get id => _id;
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get currencyName => _currencyName;
  String? get currencySimbol => _currencySimbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country_code'] = _countryCode;
    map['country_name'] = _countryName;
    map['currency_name'] = _currencyName;
    map['currency_simbol'] = _currencySimbol;
    return map;
  }

}