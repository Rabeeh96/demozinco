import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"3704cb4a-a216-4770-80e9-bcb8c1970722","from_account":{"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"Updated Acdcount","amount":200.0},"from_country":{"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"},"to_account":{"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"Updated Acdcount","amount":200.0},"to_country":{"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"},"transfer_id":1,"date":"2023-06-01","time":"12:34:56","from_amount":"100.00000000","to_amount":"200.00000000","description":"your-description-value","organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}

DetailTransactionModelClass detailTransactionModelClassFromJson(String str) => DetailTransactionModelClass.fromJson(json.decode(str));
String detailTransactionModelClassToJson(DetailTransactionModelClass data) => json.encode(data.toJson());
class DetailTransactionModelClass {
  DetailTransactionModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DetailTransactionModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
DetailTransactionModelClass copyWith({  int? statusCode,
  Data? data,
}) => DetailTransactionModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "3704cb4a-a216-4770-80e9-bcb8c1970722"
/// from_account : {"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"Updated Acdcount","amount":200.0}
/// from_country : {"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"}
/// to_account : {"id":"47348801-9365-42f3-b7b1-ebfb9e90ee17","account_name":"Updated Acdcount","amount":200.0}
/// to_country : {"id":"f423fd4a-ab0f-401d-8713-eb3eb69c84df","country_code":"INR","country_name":"India","currency_name":"Rupee"}
/// transfer_id : 1
/// date : "2023-06-01"
/// time : "12:34:56"
/// from_amount : "100.00000000"
/// to_amount : "200.00000000"
/// description : "your-description-value"
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      FromAccount? fromAccount, 
      FromCountry? fromCountry, 
      ToAccount? toAccount, 
      ToCountry? toCountry, 
      int? transferId, 
      String? date, 
      String? time, 
      String? fromAmount, 
      String? toAmount, 
      String? description, 
      String? organization,}){
    _id = id;
    _fromAccount = fromAccount;
    _fromCountry = fromCountry;
    _toAccount = toAccount;
    _toCountry = toCountry;
    _transferId = transferId;
    _date = date;
    _time = time;
    _fromAmount = fromAmount;
    _toAmount = toAmount;
    _description = description;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fromAccount = json['from_account'] != null ? FromAccount.fromJson(json['from_account']) : null;
    _fromCountry = json['from_country'] != null ? FromCountry.fromJson(json['from_country']) : null;
    _toAccount = json['to_account'] != null ? ToAccount.fromJson(json['to_account']) : null;
    _toCountry = json['to_country'] != null ? ToCountry.fromJson(json['to_country']) : null;
    _transferId = json['transfer_id'];
    _date = json['date'];
    _time = json['time'];
    _fromAmount = json['from_amount'];
    _toAmount = json['to_amount'];
    _description = json['description'];
    _organization = json['organization'];
  }
  String? _id;
  FromAccount? _fromAccount;
  FromCountry? _fromCountry;
  ToAccount? _toAccount;
  ToCountry? _toCountry;
  int? _transferId;
  String? _date;
  String? _time;
  String? _fromAmount;
  String? _toAmount;
  String? _description;
  String? _organization;
Data copyWith({  String? id,
  FromAccount? fromAccount,
  FromCountry? fromCountry,
  ToAccount? toAccount,
  ToCountry? toCountry,
  int? transferId,
  String? date,
  String? time,
  String? fromAmount,
  String? toAmount,
  String? description,
  String? organization,
}) => Data(  id: id ?? _id,
  fromAccount: fromAccount ?? _fromAccount,
  fromCountry: fromCountry ?? _fromCountry,
  toAccount: toAccount ?? _toAccount,
  toCountry: toCountry ?? _toCountry,
  transferId: transferId ?? _transferId,
  date: date ?? _date,
  time: time ?? _time,
  fromAmount: fromAmount ?? _fromAmount,
  toAmount: toAmount ?? _toAmount,
  description: description ?? _description,
  organization: organization ?? _organization,
);
  String? get id => _id;
  FromAccount? get fromAccount => _fromAccount;
  FromCountry? get fromCountry => _fromCountry;
  ToAccount? get toAccount => _toAccount;
  ToCountry? get toCountry => _toCountry;
  int? get transferId => _transferId;
  String? get date => _date;
  String? get time => _time;
  String? get fromAmount => _fromAmount;
  String? get toAmount => _toAmount;
  String? get description => _description;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_fromAccount != null) {
      map['from_account'] = _fromAccount?.toJson();
    }
    if (_fromCountry != null) {
      map['from_country'] = _fromCountry?.toJson();
    }
    if (_toAccount != null) {
      map['to_account'] = _toAccount?.toJson();
    }
    if (_toCountry != null) {
      map['to_country'] = _toCountry?.toJson();
    }
    map['transfer_id'] = _transferId;
    map['date'] = _date;
    map['time'] = _time;
    map['from_amount'] = _fromAmount;
    map['to_amount'] = _toAmount;
    map['description'] = _description;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupee"

ToCountry toCountryFromJson(String str) => ToCountry.fromJson(json.decode(str));
String toCountryToJson(ToCountry data) => json.encode(data.toJson());
class ToCountry {
  ToCountry({
      String? id, 
      String? countryCode, 
      String? countryName, 
      String? currencyName,}){
    _id = id;
    _countryCode = countryCode;
    _countryName = countryName;
    _currencyName = currencyName;
}

  ToCountry.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currencyName;
ToCountry copyWith({  String? id,
  String? countryCode,
  String? countryName,
  String? currencyName,
}) => ToCountry(  id: id ?? _id,
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

/// id : "47348801-9365-42f3-b7b1-ebfb9e90ee17"
/// account_name : "Updated Acdcount"
/// amount : 200.0

ToAccount toAccountFromJson(String str) => ToAccount.fromJson(json.decode(str));
String toAccountToJson(ToAccount data) => json.encode(data.toJson());
class ToAccount {
  ToAccount({
      String? id, 
      String? accountName, 
      double? amount,}){
    _id = id;
    _accountName = accountName;
    _amount = amount;
}

  ToAccount.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _amount = json['amount'];
  }
  String? _id;
  String? _accountName;
  double? _amount;
ToAccount copyWith({  String? id,
  String? accountName,
  double? amount,
}) => ToAccount(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get accountName => _accountName;
  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    return map;
  }

}

/// id : "f423fd4a-ab0f-401d-8713-eb3eb69c84df"
/// country_code : "INR"
/// country_name : "India"
/// currency_name : "Rupee"

FromCountry fromCountryFromJson(String str) => FromCountry.fromJson(json.decode(str));
String fromCountryToJson(FromCountry data) => json.encode(data.toJson());
class FromCountry {
  FromCountry({
      String? id, 
      String? countryCode, 
      String? countryName, 
      String? currencyName,}){
    _id = id;
    _countryCode = countryCode;
    _countryName = countryName;
    _currencyName = currencyName;
}

  FromCountry.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currencyName = json['currency_name'];
  }
  String? _id;
  String? _countryCode;
  String? _countryName;
  String? _currencyName;
FromCountry copyWith({  String? id,
  String? countryCode,
  String? countryName,
  String? currencyName,
}) => FromCountry(  id: id ?? _id,
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

/// id : "47348801-9365-42f3-b7b1-ebfb9e90ee17"
/// account_name : "Updated Acdcount"
/// amount : 200.0

FromAccount fromAccountFromJson(String str) => FromAccount.fromJson(json.decode(str));
String fromAccountToJson(FromAccount data) => json.encode(data.toJson());
class FromAccount {
  FromAccount({
      String? id, 
      String? accountName, 
      double? amount,}){
    _id = id;
    _accountName = accountName;
    _amount = amount;
}

  FromAccount.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _amount = json['amount'];
  }
  String? _id;
  String? _accountName;
  double? _amount;
FromAccount copyWith({  String? id,
  String? accountName,
  double? amount,
}) => FromAccount(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get accountName => _accountName;
  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    return map;
  }

}