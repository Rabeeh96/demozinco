/// StatusCode : 6000
/// data : {"id":"9dac30a5-ba48-4b53-b87c-82786d280312","organization":"85705232-6fba-46ba-93e7-e560145ab0e0","accounts_id":"21","account_name":"SBI Bank","account_type":"2","as_on_date":"2023-08-08","opening_balance":"0.00000000","balance":"-54133.70000000","country":{"id":"3453630b-b280-43e7-9b3f-fb4d595b5148","country_code":"INR","country_name":"India","currency_name":"Rupees"},"is_default":false,"amount_details":{"total_zakath":"0","total_interest":"0","usable":"-54133.7"}}

class DashboardDEtailModel {
  DashboardDEtailModel({
      num? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DashboardDEtailModel.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  Data? _data;
DashboardDEtailModel copyWith({  num? statusCode,
  Data? data,
}) => DashboardDEtailModel(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
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

/// id : "9dac30a5-ba48-4b53-b87c-82786d280312"
/// organization : "85705232-6fba-46ba-93e7-e560145ab0e0"
/// accounts_id : "21"
/// account_name : "SBI Bank"
/// account_type : "2"
/// as_on_date : "2023-08-08"
/// opening_balance : "0.00000000"
/// balance : "-54133.70000000"
/// country : {"id":"3453630b-b280-43e7-9b3f-fb4d595b5148","country_code":"INR","country_name":"India","currency_name":"Rupees"}
/// is_default : false
/// amount_details : {"total_zakath":"0","total_interest":"0","usable":"-54133.7"}

class Data {
  Data({
      String? id, 
      String? organization, 
      String? accountsId, 
      String? accountName, 
      String? accountType, 
      String? asOnDate, 
      String? openingBalance, 
      String? balance, 
      Country? country, 
      bool? isDefault, 
      AmountDetails? amountDetails,}){
    _id = id;
    _organization = organization;
    _accountsId = accountsId;
    _accountName = accountName;
    _accountType = accountType;
    _asOnDate = asOnDate;
    _openingBalance = openingBalance;
    _balance = balance;
    _country = country;
    _isDefault = isDefault;
    _amountDetails = amountDetails;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _organization = json['organization'];
    _accountsId = json['accounts_id'].toString();
    _accountName = json['account_name'];
    _accountType = json['account_type'];
    _asOnDate = json['as_on_date'];
    _openingBalance = json['opening_balance'];
    _balance = json['balance'].toString();
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _isDefault = json['is_default'];
    _amountDetails = json['amount_details'] != null ? AmountDetails.fromJson(json['amount_details']) : null;
  }
  String? _id;
  String? _organization;
  String? _accountsId;
  String? _accountName;
  String? _accountType;
  String? _asOnDate;
  String? _openingBalance;
  String? _balance;
  Country? _country;
  bool? _isDefault;
  AmountDetails? _amountDetails;
Data copyWith({  String? id,
  String? organization,
  String? accountsId,
  String? accountName,
  String? accountType,
  String? asOnDate,
  String? openingBalance,
  String? balance,
  Country? country,
  bool? isDefault,
  AmountDetails? amountDetails,
}) => Data(  id: id ?? _id,
  organization: organization ?? _organization,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  accountType: accountType ?? _accountType,
  asOnDate: asOnDate ?? _asOnDate,
  openingBalance: openingBalance ?? _openingBalance,
  balance: balance ?? _balance,
  country: country ?? _country,
  isDefault: isDefault ?? _isDefault,
  amountDetails: amountDetails ?? _amountDetails,
);
  String? get id => _id;
  String? get organization => _organization;
  String? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get accountType => _accountType;
  String? get asOnDate => _asOnDate;
  String? get openingBalance => _openingBalance;
  String? get balance => _balance;
  Country? get country => _country;
  bool? get isDefault => _isDefault;
  AmountDetails? get amountDetails => _amountDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['organization'] = _organization;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['account_type'] = _accountType;
    map['as_on_date'] = _asOnDate;
    map['opening_balance'] = _openingBalance;
    map['balance'] = _balance;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['is_default'] = _isDefault;
    if (_amountDetails != null) {
      map['amount_details'] = _amountDetails?.toJson();
    }
    return map;
  }

}

/// total_zakath : "0"
/// total_interest : "0"
/// usable : "-54133.7"

class AmountDetails {
  AmountDetails({
      String? totalZakath, 
      String? totalInterest, 
      String? usable,}){
    _totalZakath = totalZakath;
    _totalInterest = totalInterest;
    _usable = usable;
}

  AmountDetails.fromJson(dynamic json) {
    _totalZakath = json['total_zakath'].toString();
    _totalInterest = json['total_interest'].toString();
    _usable = json['usable'].toString();
  }
  String? _totalZakath;
  String? _totalInterest;
  String? _usable;
AmountDetails copyWith({  String? totalZakath,
  String? totalInterest,
  String? usable,
}) => AmountDetails(  totalZakath: totalZakath ?? _totalZakath,
  totalInterest: totalInterest ?? _totalInterest,
  usable: usable ?? _usable,
);
  String? get totalZakath => _totalZakath;
  String? get totalInterest => _totalInterest;
  String? get usable => _usable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_zakath'] = _totalZakath;
    map['total_interest'] = _totalInterest;
    map['usable'] = _usable;
    return map;
  }

}

/// id : "3453630b-b280-43e7-9b3f-fb4d595b5148"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupees"

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