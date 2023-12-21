import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed UserDeatils"
/// data : {"id":7,"username":"Tdgdddhyhfjjt","email":"gdfg@gamil.com","first_name":"sddtaff","user_type_name":"Testone ","phone_numbers":[{"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129","id":"549d1d38-1a02-4f06-b86f-79b36fcd3222","phone":"15384946464948"}],"organization":[],"created_user_id":1,"updated_user_id":1,"created_date":"2023-05-26T05:06:14.494380Z","updated_date":"2023-05-26T06:04:47.637974Z","action":"A","is_delete":false,"password":"9*Uj2hwU","photo":null,"is_admin":false,"user":7,"user_type":"14c0d17e-dac6-4267-8121-5a177bba8901"}

DetailUserModelClass detailUserModelClassFromJson(String str) => DetailUserModelClass.fromJson(json.decode(str));
String detailUserModelClassToJson(DetailUserModelClass data) => json.encode(data.toJson());
class DetailUserModelClass {
  DetailUserModelClass({
      int? statusCode, 
      String? message, 
      Data? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  DetailUserModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  String? _message;
  Data? _data;
DetailUserModelClass copyWith({  int? statusCode,
  String? message,
  Data? data,
}) => DetailUserModelClass(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 7
/// username : "Tdgdddhyhfjjt"
/// email : "gdfg@gamil.com"
/// first_name : "sddtaff"
/// user_type_name : "Testone "
/// phone_numbers : [{"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129","id":"549d1d38-1a02-4f06-b86f-79b36fcd3222","phone":"15384946464948"}]
/// organization : []
/// created_user_id : 1
/// updated_user_id : 1
/// created_date : "2023-05-26T05:06:14.494380Z"
/// updated_date : "2023-05-26T06:04:47.637974Z"
/// action : "A"
/// is_delete : false
/// password : "9*Uj2hwU"
/// photo : null
/// is_admin : false
/// user : 7
/// user_type : "14c0d17e-dac6-4267-8121-5a177bba8901"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? username, 
      String? email, 
      String? firstName, 
      String? userTypeName, 
      List<PhoneNumbers>? phoneNumbers, 
      List<dynamic>? organization, 
      int? createdUserId, 
      int? updatedUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      String? password, 
      dynamic photo, 
      bool? isAdmin, 
      int? user, 
      String? userType,}){
    _id = id;
    _username = username;
    _email = email;
    _firstName = firstName;
    _userTypeName = userTypeName;
    _phoneNumbers = phoneNumbers;
    _organization = organization;
    _createdUserId = createdUserId;
    _updatedUserId = updatedUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
    _password = password;
    _photo = photo;
    _isAdmin = isAdmin;
    _user = user;
    _userType = userType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _firstName = json['first_name'];
    _userTypeName = json['user_type_name'];
    if (json['phone_numbers'] != null) {
      _phoneNumbers = [];
      json['phone_numbers'].forEach((v) {
        _phoneNumbers?.add(PhoneNumbers.fromJson(v));
      });
    }
    // if (json['organization'] != null) {
    //   _organization = [];
    //   json['organization'].forEach((v) {
    //     _organization?.add(Dynamic.fromJson(v));
    //   });
    // }
    _createdUserId = json['created_user_id'];
    _updatedUserId = json['updated_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _password = json['password'];
    _photo = json['photo'] ?? "";
    _isAdmin = json['is_admin'];
    _user = json['user'];
    _userType = json['user_type'];
  }
  int? _id;
  String? _username;
  String? _email;
  String? _firstName;
  String? _userTypeName;
  List<PhoneNumbers>? _phoneNumbers;
  List<dynamic>? _organization;
  int? _createdUserId;
  int? _updatedUserId;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  String? _password;
  dynamic _photo;
  bool? _isAdmin;
  int? _user;
  String? _userType;
Data copyWith({  int? id,
  String? username,
  String? email,
  String? firstName,
  String? userTypeName,
  List<PhoneNumbers>? phoneNumbers,
  List<dynamic>? organization,
  int? createdUserId,
  int? updatedUserId,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  String? password,
  dynamic photo,
  bool? isAdmin,
  int? user,
  String? userType,
}) => Data(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  userTypeName: userTypeName ?? _userTypeName,
  phoneNumbers: phoneNumbers ?? _phoneNumbers,
  organization: organization ?? _organization,
  createdUserId: createdUserId ?? _createdUserId,
  updatedUserId: updatedUserId ?? _updatedUserId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  password: password ?? _password,
  photo: photo ?? _photo,
  isAdmin: isAdmin ?? _isAdmin,
  user: user ?? _user,
  userType: userType ?? _userType,
);
  int? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get userTypeName => _userTypeName;
  List<PhoneNumbers>? get phoneNumbers => _phoneNumbers;
  List<dynamic>? get organization => _organization;
  int? get createdUserId => _createdUserId;
  int? get updatedUserId => _updatedUserId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  String? get password => _password;
  dynamic get photo => _photo;
  bool? get isAdmin => _isAdmin;
  int? get user => _user;
  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['user_type_name'] = _userTypeName;
    if (_phoneNumbers != null) {
      map['phone_numbers'] = _phoneNumbers?.map((v) => v.toJson()).toList();
    }
    if (_organization != null) {
      map['organization'] = _organization?.map((v) => v.toJson()).toList();
    }
    map['created_user_id'] = _createdUserId;
    map['updated_user_id'] = _updatedUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['password'] = _password;
    map['photo'] = _photo;
    map['is_admin'] = _isAdmin;
    map['user'] = _user;
    map['user_type'] = _userType;
    return map;
  }

}

/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"
/// id : "549d1d38-1a02-4f06-b86f-79b36fcd3222"
/// phone : "15384946464948"

PhoneNumbers phoneNumbersFromJson(String str) => PhoneNumbers.fromJson(json.decode(str));
String phoneNumbersToJson(PhoneNumbers data) => json.encode(data.toJson());
class PhoneNumbers {
  PhoneNumbers({
      String? organization, 
      String? id, 
      String? phone,}){
    _organization = organization;
    _id = id;
    _phone = phone;
}

  PhoneNumbers.fromJson(dynamic json) {
    _organization = json['organization'];
    _id = json['id'];
    _phone = json['phone'];
  }
  String? _organization;
  String? _id;
  String? _phone;
PhoneNumbers copyWith({  String? organization,
  String? id,
  String? phone,
}) => PhoneNumbers(  organization: organization ?? _organization,
  id: id ?? _id,
  phone: phone ?? _phone,
);
  String? get organization => _organization;
  String? get id => _id;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['organization'] = _organization;
    map['id'] = _id;
    map['phone'] = _phone;
    return map;
  }

}