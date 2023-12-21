import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed Users"
/// data : [{"id":7,"username":"Sgsggsgs","first_name":"Test","email":"whwhwb@gmail.com","phone_numbers":[{"phone":"15384946464948"}]},{"id":8,"username":"Sampleone","first_name":"Sample","email":"s@gmail.com","phone_numbers":[{"phone":"123456789"}]}]

ListUserModelClass listUserModelClassFromJson(String str) => ListUserModelClass.fromJson(json.decode(str));
String listUserModelClassToJson(ListUserModelClass data) => json.encode(data.toJson());
class ListUserModelClass {
  ListUserModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ListUserModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  String? _message;
  List<Data>? _data;
ListUserModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => ListUserModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 7
/// username : "Sgsggsgs"
/// first_name : "Test"
/// email : "whwhwb@gmail.com"
/// phone_numbers : [{"phone":"15384946464948"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? username, 
      String? firstName, 
      String? email, 
      List<PhoneNumbers>? phoneNumbers,}){
    _id = id;
    _username = username;
    _firstName = firstName;
    _email = email;
    _phoneNumbers = phoneNumbers;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _firstName = json['first_name'];
    _email = json['email'];
    if (json['phone_numbers'] != null) {
      _phoneNumbers = [];
      json['phone_numbers'].forEach((v) {
        _phoneNumbers?.add(PhoneNumbers.fromJson(v));
      });
    }
  }
  int? _id;
  String? _username;
  String? _firstName;
  String? _email;
  List<PhoneNumbers>? _phoneNumbers;
Data copyWith({  int? id,
  String? username,
  String? firstName,
  String? email,
  List<PhoneNumbers>? phoneNumbers,
}) => Data(  id: id ?? _id,
  username: username ?? _username,
  firstName: firstName ?? _firstName,
  email: email ?? _email,
  phoneNumbers: phoneNumbers ?? _phoneNumbers,
);
  int? get id => _id;
  String? get username => _username;
  String? get firstName => _firstName;
  String? get email => _email;
  List<PhoneNumbers>? get phoneNumbers => _phoneNumbers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['first_name'] = _firstName;
    map['email'] = _email;
    if (_phoneNumbers != null) {
      map['phone_numbers'] = _phoneNumbers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// phone : "15384946464948"

PhoneNumbers phoneNumbersFromJson(String str) => PhoneNumbers.fromJson(json.decode(str));
String phoneNumbersToJson(PhoneNumbers data) => json.encode(data.toJson());
class PhoneNumbers {
  PhoneNumbers({
      String? phone,}){
    _phone = phone;
}

  PhoneNumbers.fromJson(dynamic json) {
    _phone = json['phone'];
  }
  String? _phone;
PhoneNumbers copyWith({  String? phone,
}) => PhoneNumbers(  phone: phone ?? _phone,
);
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    return map;
  }

}