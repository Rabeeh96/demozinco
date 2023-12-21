import 'dart:convert';
/// StatusCode : 6000
/// data : {"id":"35cf1533-4867-4d91-8ee2-05bdc5157129","profiles":{"id":1,"photo":"/media/profiles/wallpaperflare.com_wallpaper2.jpg","phone":[{"phone":"987654456"},{"phone":"987654456"}],"is_admin":true,"first_name":"razeenakk","last_name":"KK\n","email":"rz@gmail.com","username":"zincoadmin"},"created_user_id":1,"created_date":"2023-05-16T09:36:25.407606Z","updated_date":"2023-05-16T09:36:25.407633Z","action":"A","is_delete":false,"organization_id":1,"expiry_date":"2023-06-01","is_reminder":true,"is_zakath":true,"is_interest":true}

SettingsModelClass settingsModelClassFromJson(String str) => SettingsModelClass.fromJson(json.decode(str));
String settingsModelClassToJson(SettingsModelClass data) => json.encode(data.toJson());
class SettingsModelClass {
  SettingsModelClass({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  SettingsModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;
SettingsModelClass copyWith({  int? statusCode,
  Data? data,
}) => SettingsModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "35cf1533-4867-4d91-8ee2-05bdc5157129"
/// profiles : {"id":1,"photo":"/media/profiles/wallpaperflare.com_wallpaper2.jpg","phone":[{"phone":"987654456"},{"phone":"987654456"}],"is_admin":true,"first_name":"razeenakk","last_name":"KK\n","email":"rz@gmail.com","username":"zincoadmin"}
/// created_user_id : 1
/// created_date : "2023-05-16T09:36:25.407606Z"
/// updated_date : "2023-05-16T09:36:25.407633Z"
/// action : "A"
/// is_delete : false
/// organization_id : 1
/// expiry_date : "2023-06-01"
/// is_reminder : true
/// is_zakath : true
/// is_interest : true

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Profiles? profiles, 
      int? createdUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      int? organizationId, 
      int? rounding,
      String? expiryDate,
      bool? isReminder, 
      bool? isZakath, 
      bool? isInterest,}){
    _id = id;
    _profiles = profiles;
    _createdUserId = createdUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _rounding = rounding;
    _isDelete = isDelete;
    _organizationId = organizationId;
    _expiryDate = expiryDate;
    _isReminder = isReminder;
    _isZakath = isZakath;
    _isInterest = isInterest;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _profiles = json['profiles'] != null ? Profiles.fromJson(json['profiles']) : null;
    _createdUserId = json['created_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _rounding = json['rounding'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _organizationId = json['organization_id'];
    _expiryDate = json['expiry_date'];
    _isReminder = json['is_reminder'];
    _isZakath = json['is_zakath'];
    _isInterest = json['is_interest'];
  }
  String? _id;
  Profiles? _profiles;
  int? _createdUserId;
  int? _rounding;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  int? _organizationId;
  String? _expiryDate;
  bool? _isReminder;
  bool? _isZakath;
  bool? _isInterest;
Data copyWith({  String? id,
  Profiles? profiles,
  int? createdUserId,
  int? rounding,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  int? organizationId,
  String? expiryDate,
  bool? isReminder,
  bool? isZakath,
  bool? isInterest,
}) => Data(  id: id ?? _id,
  profiles: profiles ?? _profiles,
  createdUserId: createdUserId ?? _createdUserId,
  createdDate: createdDate ?? _createdDate,
  rounding: rounding ?? _rounding,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  organizationId: organizationId ?? _organizationId,
  expiryDate: expiryDate ?? _expiryDate,
  isReminder: isReminder ?? _isReminder,
  isZakath: isZakath ?? _isZakath,
  isInterest: isInterest ?? _isInterest,
);
  String? get id => _id;
  Profiles? get profiles => _profiles;
  int? get createdUserId => _createdUserId;
  int? get rounding => _rounding;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get organizationId => _organizationId;
  String? get expiryDate => _expiryDate;
  bool? get isReminder => _isReminder;
  bool? get isZakath => _isZakath;
  bool? get isInterest => _isInterest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_profiles != null) {
      map['profiles'] = _profiles?.toJson();
    }
    map['created_user_id'] = _createdUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['rounding'] = _rounding;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['organization_id'] = _organizationId;
    map['expiry_date'] = _expiryDate;
    map['is_reminder'] = _isReminder;
    map['is_zakath'] = _isZakath;
    map['is_interest'] = _isInterest;
    return map;
  }

}

/// id : 1
/// photo : "/media/profiles/wallpaperflare.com_wallpaper2.jpg"
/// phone : [{"phone":"987654456"},{"phone":"987654456"}]
/// is_admin : true
/// first_name : "razeenakk"
/// last_name : "KK\n"
/// email : "rz@gmail.com"
/// username : "zincoadmin"

Profiles profilesFromJson(String str) => Profiles.fromJson(json.decode(str));
String profilesToJson(Profiles data) => json.encode(data.toJson());
class Profiles {
  Profiles({
      int? id, 
      String? photo, 
      List<Phone>? phone, 
      bool? isAdmin, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? username,}){
    _id = id;
    _photo = photo;
    _phone = phone;
    _isAdmin = isAdmin;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _username = username;
}

  Profiles.fromJson(dynamic json) {
    _id = json['id'];
    _photo = json['photo']?? "";
    if (json['phone'] != null) {
      _phone = [];
      json['phone'].forEach((v) {
        _phone?.add(Phone.fromJson(v));
      });
    }
    _isAdmin = json['is_admin'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _username = json['username'];
  }
  int? _id;
  String? _photo;
  List<Phone>? _phone;
  bool? _isAdmin;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _username;
Profiles copyWith({  int? id,
  String? photo,
  List<Phone>? phone,
  bool? isAdmin,
  String? firstName,
  String? lastName,
  String? email,
  String? username,
}) => Profiles(  id: id ?? _id,
  photo: photo ?? _photo,
  phone: phone ?? _phone,
  isAdmin: isAdmin ?? _isAdmin,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  username: username ?? _username,
);
  int? get id => _id;
  String? get photo => _photo;
  List<Phone>? get phone => _phone;
  bool? get isAdmin => _isAdmin;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['photo'] = _photo;
    if (_phone != null) {
      map['phone'] = _phone?.map((v) => v.toJson()).toList();
    }
    map['is_admin'] = _isAdmin;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['username'] = _username;
    return map;
  }

}

/// phone : "987654456"

Phone phoneFromJson(String str) => Phone.fromJson(json.decode(str));
String phoneToJson(Phone data) => json.encode(data.toJson());
class Phone {
  Phone({
      String? phone,}){
    _phone = phone;
}

  Phone.fromJson(dynamic json) {
    _phone = json['phone'];
  }
  String? _phone;
Phone copyWith({  String? phone,
}) => Phone(  phone: phone ?? _phone,
);
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    return map;
  }

}