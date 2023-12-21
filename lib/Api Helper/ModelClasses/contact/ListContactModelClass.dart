import 'dart:convert';
/// StatusCode : 6000
/// total_recievable : 469.12
/// total_payable : 0.0
/// data : [{"id":"1824771a-572d-4b0d-a864-f3792c5408d3","account_name":"Abhanya Vikn","photo":"","total_received":469.12,"total_paid":0,"phone":"+919946558450"},{"id":"b09871d8-5925-4914-a434-66ebf7d40cfb","account_name":"AL friendz chat","photo":"","total_received":0,"total_paid":0,"phone":"543216"}]
/// accounts_list : [{"account_name":"Union","balance":24684.0,"account_type":2},{"account_name":"Boi","balance":2062.0,"account_type":2},{"account_name":"My Cas","balance":100025.0,"account_type":2},{"account_name":"Canara","balance":-1141.33,"account_type":2},{"account_name":"My Cash","balance":24997329.21,"account_type":1}]
/// count : 2
/// current_page : 1
/// total_pages : 1
/// next_page : null
/// previous_page : null

ListContactModelClass listContactModelClassFromJson(String str) => ListContactModelClass.fromJson(json.decode(str));
String listContactModelClassToJson(ListContactModelClass data) => json.encode(data.toJson());
class ListContactModelClass {
  ListContactModelClass({
      int? statusCode, 
      String? totalRecievable,
      String? totalPayable,
      List<Data>? data, 
      List<AccountsList>? accountsList, 
      int? count, 
      int? currentPage, 
      int? totalPages, 
      dynamic nextPage, 
      dynamic previousPage,}){
    _statusCode = statusCode;
    _totalRecievable = totalRecievable;
    _totalPayable = totalPayable;
    _data = data;
    _accountsList = accountsList;
    _count = count;
    _currentPage = currentPage;
    _totalPages = totalPages;
    _nextPage = nextPage;
    _previousPage = previousPage;
}

  ListContactModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _totalRecievable = json['total_recievable'].toString();
    _totalPayable = json['total_payable'].toString();
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['accounts_list'] != null) {
      _accountsList = [];
      json['accounts_list'].forEach((v) {
        _accountsList?.add(AccountsList.fromJson(v));
      });
    }
    _count = json['count'];
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _nextPage = json['next_page'];
    _previousPage = json['previous_page'];
  }
  int? _statusCode;
  String? _totalRecievable;
  String? _totalPayable;
  List<Data>? _data;
  List<AccountsList>? _accountsList;
  int? _count;
  int? _currentPage;
  int? _totalPages;
  dynamic _nextPage;
  dynamic _previousPage;
ListContactModelClass copyWith({  int? statusCode,
  String? totalRecievable,
  String? totalPayable,
  List<Data>? data,
  List<AccountsList>? accountsList,
  int? count,
  int? currentPage,
  int? totalPages,
  dynamic nextPage,
  dynamic previousPage,
}) => ListContactModelClass(  statusCode: statusCode ?? _statusCode,
  totalRecievable: totalRecievable ?? _totalRecievable,
  totalPayable: totalPayable ?? _totalPayable,
  data: data ?? _data,
  accountsList: accountsList ?? _accountsList,
  count: count ?? _count,
  currentPage: currentPage ?? _currentPage,
  totalPages: totalPages ?? _totalPages,
  nextPage: nextPage ?? _nextPage,
  previousPage: previousPage ?? _previousPage,
);
  int? get statusCode => _statusCode;
  String? get totalRecievable => _totalRecievable;
  String? get totalPayable => _totalPayable;
  List<Data>? get data => _data;
  List<AccountsList>? get accountsList => _accountsList;
  int? get count => _count;
  int? get currentPage => _currentPage;
  int? get totalPages => _totalPages;
  dynamic get nextPage => _nextPage;
  dynamic get previousPage => _previousPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['total_recievable'] = _totalRecievable;
    map['total_payable'] = _totalPayable;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_accountsList != null) {
      map['accounts_list'] = _accountsList?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    map['current_page'] = _currentPage;
    map['total_pages'] = _totalPages;
    map['next_page'] = _nextPage;
    map['previous_page'] = _previousPage;
    return map;
  }

}

/// account_name : "Union"
/// balance : 24684.0
/// account_type : 2

AccountsList accountsListFromJson(String str) => AccountsList.fromJson(json.decode(str));
String accountsListToJson(AccountsList data) => json.encode(data.toJson());
class AccountsList {
  AccountsList({
      String? accountName, 
      String? balance,
      String? id,
      int? accountType,}){
    _accountName = accountName;
    _id = id;
    _balance = balance;
    _accountType = accountType;
}

  AccountsList.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _id = json['id'];
    _balance = json['balance'].toString();
    _accountType = json['account_type'];
  }
  String? _accountName;
  String? _balance;
  String? _id;
  int? _accountType;
AccountsList copyWith({  String? accountName, String? id,
  String? balance,
  int? accountType,
}) => AccountsList(  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
  id: id ?? _id,
  accountType: accountType ?? _accountType,
);
  String? get accountName => _accountName;
  String? get balance => _balance;
  String? get id => _id;
  int? get accountType => _accountType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['id'] = _id;
    map['balance'] = _balance;
    map['account_type'] = _accountType;
    return map;
  }

}

/// id : "1824771a-572d-4b0d-a864-f3792c5408d3"
/// account_name : "Abhanya Vikn"
/// photo : ""
/// total_received : 469.12
/// total_paid : 0
/// phone : "+919946558450"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? accountName, 
      String? photo, 
      String? totalReceived,
      String? totalPaid,
      String? phone,}){
    _id = id;
    _accountName = accountName;
    _photo = photo;
    _totalReceived = totalReceived;
    _totalPaid = totalPaid;
    _phone = phone;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _photo = json['photo'];
    _totalReceived = json['total_received'].toString();
    _totalPaid = json['total_paid'].toString();
    _phone = json['phone'];
  }
  String? _id;
  String? _accountName;
  String? _photo;
  String? _totalReceived;
  String? _totalPaid;
  String? _phone;
Data copyWith({  String? id,
  String? accountName,
  String? photo,
  String? totalReceived,
  String? totalPaid,
  String? phone,
}) => Data(  id: id ?? _id,
  accountName: accountName ?? _accountName,
  photo: photo ?? _photo,
  totalReceived: totalReceived ?? _totalReceived,
  totalPaid: totalPaid ?? _totalPaid,
  phone: phone ?? _phone,
);
  String? get id => _id;
  String? get accountName => _accountName;
  String? get photo => _photo;
  String? get totalReceived => _totalReceived;
  String? get totalPaid => _totalPaid;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['photo'] = _photo;
    map['total_received'] = _totalReceived;
    map['total_paid'] = _totalPaid;
    map['phone'] = _phone;
    return map;
  }

}