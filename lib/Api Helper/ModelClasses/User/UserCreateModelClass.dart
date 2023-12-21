import 'dart:convert';
/// StatusCode : 6000
/// message : "A user with that username already exists."
/// data : {"first_name":"stdddoaff","username":"Tdfddjjt","email":"gddd@gamil.com","password1":"123456","password2":"123456","phone":"987654456","user_type_id":"14c0d17e-dac6-4267-8121-5a177bba8901"}
/// userID : 9

UserCreateModelClass userCreateModelClassFromJson(String str) => UserCreateModelClass.fromJson(json.decode(str));
String userCreateModelClassToJson(UserCreateModelClass data) => json.encode(data.toJson());
class UserCreateModelClass {
  UserCreateModelClass({
      int? statusCode, 
      String? message, 
      Data? data, 
      int? userID,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _userID = userID;
}

  UserCreateModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _userID = json['userID'];
  }
  int? _statusCode;
  String? _message;
  Data? _data;
  int? _userID;
UserCreateModelClass copyWith({  int? statusCode,
  String? message,
  Data? data,
  int? userID,
}) => UserCreateModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
  userID: userID ?? _userID,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;
  int? get userID => _userID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['userID'] = _userID;
    return map;
  }

}

/// first_name : "stdddoaff"
/// username : "Tdfddjjt"
/// email : "gddd@gamil.com"
/// password1 : "123456"
/// password2 : "123456"
/// phone : "987654456"
/// user_type_id : "14c0d17e-dac6-4267-8121-5a177bba8901"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? firstName, 
      String? username, 
      String? email, 
      String? password1, 
      String? password2, 
      String? phone, 
      String? userTypeId,}){
    _firstName = firstName;
    _username = username;
    _email = email;
    _password1 = password1;
    _password2 = password2;
    _phone = phone;
    _userTypeId = userTypeId;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _username = json['username'];
    _email = json['email'];
    _password1 = json['password1'];
    _password2 = json['password2'];
    _phone = json['phone'];
    _userTypeId = json['user_type_id'];
  }
  String? _firstName;
  String? _username;
  String? _email;
  String? _password1;
  String? _password2;
  String? _phone;
  String? _userTypeId;
Data copyWith({  String? firstName,
  String? username,
  String? email,
  String? password1,
  String? password2,
  String? phone,
  String? userTypeId,
}) => Data(  firstName: firstName ?? _firstName,
  username: username ?? _username,
  email: email ?? _email,
  password1: password1 ?? _password1,
  password2: password2 ?? _password2,
  phone: phone ?? _phone,
  userTypeId: userTypeId ?? _userTypeId,
);
  String? get firstName => _firstName;
  String? get username => _username;
  String? get email => _email;
  String? get password1 => _password1;
  String? get password2 => _password2;
  String? get phone => _phone;
  String? get userTypeId => _userTypeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['username'] = _username;
    map['email'] = _email;
    map['password1'] = _password1;
    map['password2'] = _password2;
    map['phone'] = _phone;
    map['user_type_id'] = _userTypeId;
    return map;
  }

}