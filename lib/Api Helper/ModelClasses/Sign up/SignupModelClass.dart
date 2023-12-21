import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully registered user. Please verify your email."
/// country : "bb5f1950-a164-47b7-a42d-e5a62cb9e0e2"
/// userID : 65
/// email : "b1686@ipent.com"

SignupModelClass signupModelClassFromJson(String str) => SignupModelClass.fromJson(json.decode(str));
String signupModelClassToJson(SignupModelClass data) => json.encode(data.toJson());
class SignupModelClass {
  SignupModelClass({
      int? statusCode, 
      String? message, 
      String? country, 
      int? userID, 
      String? email,}){
    _statusCode = statusCode;
    _message = message;
    _country = country;
    _userID = userID;
    _email = email;
}

  SignupModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _country = json['country'];
    _userID = json['userID'];
    _email = json['email'];
  }
  int? _statusCode;
  String? _message;
  String? _country;
  int? _userID;
  String? _email;
SignupModelClass copyWith({  int? statusCode,
  String? message,
  String? country,
  int? userID,
  String? email,
}) => SignupModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  country: country ?? _country,
  userID: userID ?? _userID,
  email: email ?? _email,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  String? get country => _country;
  int? get userID => _userID;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    map['country'] = _country;
    map['userID'] = _userID;
    map['email'] = _email;
    return map;
  }

}