import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed UserRole"
/// data : [{"id":"a3ca65f6-4f0a-4fa8-bde7-5a262377e56f","user_type":{"id":"14c0d17e-dac6-4267-8121-5a177bba8901","user_type_id":17,"user_type_name":"Testone "},"created_user_id":1,"created_date":"2023-05-25T05:37:56.480290Z","updated_date":"2023-05-25T05:37:56.480319Z","action":"A","is_delete":false,"user_role_id":89,"name":"Transactions","view_permission":false,"save_permission":false,"edit_permission":false,"delete_permission":false,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"}]

DetailUseroleModelClass detailUseroleModelClassFromJson(String str) => DetailUseroleModelClass.fromJson(json.decode(str));
String detailUseroleModelClassToJson(DetailUseroleModelClass data) => json.encode(data.toJson());
class DetailUseroleModelClass {
  DetailUseroleModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  DetailUseroleModelClass.fromJson(dynamic json) {
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
DetailUseroleModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => DetailUseroleModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "a3ca65f6-4f0a-4fa8-bde7-5a262377e56f"
/// user_type : {"id":"14c0d17e-dac6-4267-8121-5a177bba8901","user_type_id":17,"user_type_name":"Testone "}
/// created_user_id : 1
/// created_date : "2023-05-25T05:37:56.480290Z"
/// updated_date : "2023-05-25T05:37:56.480319Z"
/// action : "A"
/// is_delete : false
/// user_role_id : 89
/// name : "Transactions"
/// view_permission : false
/// save_permission : false
/// edit_permission : false
/// delete_permission : false
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      UserType? userType, 
      int? createdUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      int? userRoleId, 
      String? name, 
      bool? viewPermission, 
      bool? savePermission, 
      bool? editPermission, 
      bool? deletePermission, 
      String? organization,}){
    _id = id;
    _userType = userType;
    _createdUserId = createdUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
    _userRoleId = userRoleId;
    _name = name;
    _viewPermission = viewPermission;
    _savePermission = savePermission;
    _editPermission = editPermission;
    _deletePermission = deletePermission;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'] != null ? UserType.fromJson(json['user_type']) : null;
    _createdUserId = json['created_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _userRoleId = json['user_role_id'];
    _name = json['name'];
    _viewPermission = json['view_permission'];
    _savePermission = json['save_permission'];
    _editPermission = json['edit_permission'];
    _deletePermission = json['delete_permission'];
    _organization = json['organization'];
  }
  String? _id;
  UserType? _userType;
  int? _createdUserId;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  int? _userRoleId;
  String? _name;
  bool? _viewPermission;
  bool? _savePermission;
  bool? _editPermission;
  bool? _deletePermission;
  String? _organization;
Data copyWith({  String? id,
  UserType? userType,
  int? createdUserId,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  int? userRoleId,
  String? name,
  bool? viewPermission,
  bool? savePermission,
  bool? editPermission,
  bool? deletePermission,
  String? organization,
}) => Data(  id: id ?? _id,
  userType: userType ?? _userType,
  createdUserId: createdUserId ?? _createdUserId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  userRoleId: userRoleId ?? _userRoleId,
  name: name ?? _name,
  viewPermission: viewPermission ?? _viewPermission,
  savePermission: savePermission ?? _savePermission,
  editPermission: editPermission ?? _editPermission,
  deletePermission: deletePermission ?? _deletePermission,
  organization: organization ?? _organization,
);
  String? get id => _id;
  UserType? get userType => _userType;
  int? get createdUserId => _createdUserId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get userRoleId => _userRoleId;
  String? get name => _name;
  bool? get viewPermission => _viewPermission;
  bool? get savePermission => _savePermission;
  bool? get editPermission => _editPermission;
  bool? get deletePermission => _deletePermission;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_userType != null) {
      map['user_type'] = _userType?.toJson();
    }
    map['created_user_id'] = _createdUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['user_role_id'] = _userRoleId;
    map['name'] = _name;
    map['view_permission'] = _viewPermission;
    map['save_permission'] = _savePermission;
    map['edit_permission'] = _editPermission;
    map['delete_permission'] = _deletePermission;
    map['organization'] = _organization;
    return map;
  }

}

/// id : "14c0d17e-dac6-4267-8121-5a177bba8901"
/// user_type_id : 17
/// user_type_name : "Testone "

UserType userTypeFromJson(String str) => UserType.fromJson(json.decode(str));
String userTypeToJson(UserType data) => json.encode(data.toJson());
class UserType {
  UserType({
      String? id, 
      int? userTypeId, 
      String? userTypeName,}){
    _id = id;
    _userTypeId = userTypeId;
    _userTypeName = userTypeName;
}

  UserType.fromJson(dynamic json) {
    _id = json['id'];
    _userTypeId = json['user_type_id'];
    _userTypeName = json['user_type_name'];
  }
  String? _id;
  int? _userTypeId;
  String? _userTypeName;
UserType copyWith({  String? id,
  int? userTypeId,
  String? userTypeName,
}) => UserType(  id: id ?? _id,
  userTypeId: userTypeId ?? _userTypeId,
  userTypeName: userTypeName ?? _userTypeName,
);
  String? get id => _id;
  int? get userTypeId => _userTypeId;
  String? get userTypeName => _userTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type_id'] = _userTypeId;
    map['user_type_name'] = _userTypeName;
    return map;
  }

}