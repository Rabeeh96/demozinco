import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"49311e5c-1eba-444b-b0d4-a77b29b5ab27","country":{"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"},"address":{"id":"06887e78-8686-497c-8aeb-ae4e9a89fe9e","address_id":18,"address_name":"Fghh","building_name":"Fghh","land_mark":"Ghhh","country":{"country_name":"India","id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"},"state":"Tggh","pin_code":"Tggh","is_default":false},"phone":{"phone":""},"action":"A","is_delete":false,"accounts_id":43,"account_name":"S5r78g","amount":"0.00000000","opening_balance":"-555.00000000","as_on_date":"","account_type":"0","photo":"","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailContactModelClass detailContactModelClassFromJson(String str) => DetailContactModelClass.fromJson(json.decode(str));
String detailContactModelClassToJson(DetailContactModelClass data) => json.encode(data.toJson());
class DetailContactModelClass {
  DetailContactModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailContactModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailContactModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "49311e5c-1eba-444b-b0d4-a77b29b5ab27"
/// country : {"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"}
/// address : {"id":"06887e78-8686-497c-8aeb-ae4e9a89fe9e","address_id":18,"address_name":"Fghh","building_name":"Fghh","land_mark":"Ghhh","country":{"country_name":"India","id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"},"state":"Tggh","pin_code":"Tggh","is_default":false}
/// phone : {"phone":""}
/// action : "A"
/// is_delete : false
/// accounts_id : 43
/// account_name : "S5r78g"
/// amount : "0.00000000"
/// opening_balance : "-555.00000000"
/// as_on_date : ""
/// account_type : "0"
/// photo : ""
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Country? country, 
      Address? address,
       String? phone,
      String? action, 
      bool? isDelete, 
      int? accountsId, 
      String? accountName, 
      String? amount, 
      String? openingBalance, 
      String? asOnDate, 
      String? accountType, 
      String? photo, 
      String? organization,}){
    _id = id;
    _country = country;
    _address = address;
    _phone = phone;
    _action = action;
    _isDelete = isDelete;
    _accountsId = accountsId;
    _accountName = accountName;
    _amount = amount;
    _openingBalance = openingBalance;
    _asOnDate = asOnDate;
    _accountType = accountType;
    _photo = photo;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _phone = json['phone']??'';
    _action = json['action']??'';
    _isDelete = json['is_delete']??'';
    _accountsId = json['accounts_id']??'';
    _accountName = json['account_name']??'';
    _amount = json['amount']??'';
    _openingBalance = json['opening_balance']??'';
    _asOnDate = json['as_on_date']??'';
    _accountType = json['account_type']??'';
    _photo = json['photo']??'';
    _organization = json['organization']??'';
  }
  String? _id;
  Country? _country;
  Address? _address;
  String? _phone;
  String? _action;
  bool? _isDelete;
  int? _accountsId;
  String? _accountName;
  String? _amount;
  String? _openingBalance;
  String? _asOnDate;
  String? _accountType;
  String? _photo;
  String? _organization;
Data copyWith({  String? id,
  Country? country,
  Address? address,
  String? phone,
  String? action,
  bool? isDelete,
  int? accountsId,
  String? accountName,
  String? amount,
  String? openingBalance,
  String? asOnDate,
  String? accountType,
  String? photo,
  String? organization,
}) => Data(  id: id ?? _id,
  country: country ?? _country,
  address: address ?? _address,
  phone: phone ?? _phone,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
  openingBalance: openingBalance ?? _openingBalance,
  asOnDate: asOnDate ?? _asOnDate,
  accountType: accountType ?? _accountType,
  photo: photo ?? _photo,
  organization: organization ?? _organization,
);
  String? get id => _id;
  Country? get country => _country;
  Address? get address => _address;
  String? get phone => _phone;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get amount => _amount;
  String? get openingBalance => _openingBalance;
  String? get asOnDate => _asOnDate;
  String? get accountType => _accountType;
  String? get photo => _photo;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    if (_address != null) {
      map['address'] = _address?.toJson();
    }

    map['phone'] = _action;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    map['opening_balance'] = _openingBalance;
    map['as_on_date'] = _asOnDate;
    map['account_type'] = _accountType;
    map['photo'] = _photo;
    map['organization'] = _organization;
    return map;
  }

}

/// phone : ""



/// id : "06887e78-8686-497c-8aeb-ae4e9a89fe9e"
/// address_id : 18
/// address_name : "Fghh"
/// building_name : "Fghh"
/// land_mark : "Ghhh"
/// country : {"country_name":"India","id":"9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"}
/// state : "Tggh"
/// pin_code : "Tggh"
/// is_default : false

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      String? id, 
      int? addressId, 
      String? addressName, 
      String? buildingName, 
      String? landMark, 
      Country? country, 
      String? state, 
      String? pinCode, 
      bool? isDefault,}){
    _id = id;
    _addressId = addressId;
    _addressName = addressName;
    _buildingName = buildingName;
    _landMark = landMark;
    _country = country;
    _state = state;
    _pinCode = pinCode;
    _isDefault = isDefault;
}

  Address.fromJson(dynamic json) {
    _id = json['id'];
    _addressId = json['address_id'];
    _addressName = json['address_name'];
    _buildingName = json['building_name'];
    _landMark = json['land_mark'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _state = json['state'];
    _pinCode = json['pin_code'];
    _isDefault = json['is_default'];
  }
  String? _id;
  int? _addressId;
  String? _addressName;
  String? _buildingName;
  String? _landMark;
  Country? _country;
  String? _state;
  String? _pinCode;
  bool? _isDefault;
Address copyWith({  String? id,
  int? addressId,
  String? addressName,
  String? buildingName,
  String? landMark,
  Country? country,
  String? state,
  String? pinCode,
  bool? isDefault,
}) => Address(  id: id ?? _id,
  addressId: addressId ?? _addressId,
  addressName: addressName ?? _addressName,
  buildingName: buildingName ?? _buildingName,
  landMark: landMark ?? _landMark,
  country: country ?? _country,
  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  isDefault: isDefault ?? _isDefault,
);
  String? get id => _id;
  int? get addressId => _addressId;
  String? get addressName => _addressName;
  String? get buildingName => _buildingName;
  String? get landMark => _landMark;
  Country? get country => _country;
  String? get state => _state;
  String? get pinCode => _pinCode;
  bool? get isDefault => _isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address_id'] = _addressId;
    map['address_name'] = _addressName;
    map['building_name'] = _buildingName;
    map['land_mark'] = _landMark;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['is_default'] = _isDefault;
    return map;
  }

}

/// country_name : "India"
/// id : "9d0d9b5c-f079-4b80-8eed-8fbc8407cee7"

Country countryFromJson(String str) => Country.fromJson(json.decode(str));
String countryToJson(Country data) => json.encode(data.toJson());
class Country {
  Country({
      String? countryName, 
      String? id,}){
    _countryName = countryName;
    _id = id;
}

  Country.fromJson(dynamic json) {
    _countryName = json['country_name'];
    _id = json['id'];
  }
  String? _countryName;
  String? _id;
Country copyWith({  String? countryName,
  String? id,
}) => Country(  countryName: countryName ?? _countryName,
  id: id ?? _id,
);
  String? get countryName => _countryName;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_name'] = _countryName;
    map['id'] = _id;
    return map;
  }

}

/// id : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupee"

CountryModel CountryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));
String CountryModelToJson(Country data) => json.encode(data.toJson());
class CountryModel {
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

  CountryModel.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currencyName;
  CountryModel copyWith({  String? id,
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