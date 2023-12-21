import 'dart:convert';
/// success : 6000
/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIyOTI0MDc2LCJpYXQiOjE2OTEzODgwNzYsImp0aSI6ImM4YmYxYWZiYmU4YjQ1YjRiYjNjZWM3YmY2ZDdlNDgxIiwidXNlcl9pZCI6Mjh9.Yz5KD3_lTLRAUHP6aIz50uJEBzaPplI-vMUjuZlFoAU"
/// refresh_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NDQ2MDA3NiwiaWF0IjoxNjkxMzg4MDc2LCJqdGkiOiI0MWY4NDdmY2Y1MWU0Yjg3OTdlNDgxOWY3ZDE2NTkyMSIsInVzZXJfaWQiOjI4fQ.rOMazbsKTkenK2wNqbBXZPgiA0xy_sIg2MT3Nrz1Pt8"
/// user_id : 28
/// role : "superuser"
/// message : "Login successfully"
/// username : "rabeeh"
/// organization : "71fc58e9-7e0a-401f-9aee-712357447fd4"

LoginModelClass loginModelClassFromJson(String str) => LoginModelClass.fromJson(json.decode(str));
String loginModelClassToJson(LoginModelClass data) => json.encode(data.toJson());
class LoginModelClass {
  LoginModelClass({
      int? success, 
      String? accessToken, 
      String? refreshToken, 
      int? userId, 
      String? role, 
      String? message, 
      String? username, 
      String? organization,}){
    _success = success;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _userId = userId;
    _role = role;
    _message = message;
    _username = username;
    _organization = organization;
}

  LoginModelClass.fromJson(dynamic json) {
    _success = json['success'];
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
    _userId = json['user_id'];
    _role = json['role'];
    _message = json['message'];
    _username = json['username'];
    _organization = json['organization'];
  }
  int? _success;
  String? _accessToken;
  String? _refreshToken;
  int? _userId;
  String? _role;
  String? _message;
  String? _username;
  String? _organization;
LoginModelClass copyWith({  int? success,
  String? accessToken,
  String? refreshToken,
  int? userId,
  String? role,
  String? message,
  String? username,
  String? organization,
}) => LoginModelClass(  success: success ?? _success,
  accessToken: accessToken ?? _accessToken,
  refreshToken: refreshToken ?? _refreshToken,
  userId: userId ?? _userId,
  role: role ?? _role,
  message: message ?? _message,
  username: username ?? _username,
  organization: organization ?? _organization,
);
  int? get success => _success;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  int? get userId => _userId;
  String? get role => _role;
  String? get message => _message;
  String? get username => _username;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['access_token'] = _accessToken;
    map['refresh_token'] = _refreshToken;
    map['user_id'] = _userId;
    map['role'] = _role;
    map['message'] = _message;
    map['username'] = _username;
    map['organization'] = _organization;
    return map;
  }

}