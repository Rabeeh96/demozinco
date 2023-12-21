import 'dart:convert';
/// StatusCode : 6000
/// message : "Successfully listed UserType"
/// data : [{"id":"028339f1-37f6-4b7d-961c-c211193c86a3","created_user_id":1,"created_date":"2023-05-18T12:05:26.808940Z","updated_date":"2023-05-18T12:05:26.808968Z","action":"A","is_delete":false,"user_type_id":13,"user_type_name":"Sampl ","notes":"","is_active":true,"organization":"35cf1533-4867-4d91-8ee2-05bdc5157129"},null]

ListUseroleModelClass listUseroleModelClassFromJson(String str) => ListUseroleModelClass.fromJson(json.decode(str));
String listUseroleModelClassToJson(ListUseroleModelClass data) => json.encode(data.toJson());
class ListUseroleModelClass {
  ListUseroleModelClass({
      int? statusCode, 
      String? message, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ListUseroleModelClass.fromJson(dynamic json) {
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
ListUseroleModelClass copyWith({  int? statusCode,
  String? message,
  List<Data>? data,
}) => ListUseroleModelClass(  statusCode: statusCode ?? _statusCode,
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

/// id : "028339f1-37f6-4b7d-961c-c211193c86a3"
/// created_user_id : 1
/// created_date : "2023-05-18T12:05:26.808940Z"
/// updated_date : "2023-05-18T12:05:26.808968Z"
/// action : "A"
/// is_delete : false
/// user_type_id : 13
/// user_type_name : "Sampl "
/// notes : ""
/// is_active : true
/// organization : "35cf1533-4867-4d91-8ee2-05bdc5157129"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      int? createdUserId, 
      String? createdDate, 
      String? updatedDate, 
      String? action, 
      bool? isDelete, 
      int? userTypeId, 
      String? userTypeName, 
      String? notes, 
      bool? isActive, 
      String? organization,}){
    _id = id;
    _createdUserId = createdUserId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _action = action;
    _isDelete = isDelete;
    _userTypeId = userTypeId;
    _userTypeName = userTypeName;
    _notes = notes;
    _isActive = isActive;
    _organization = organization;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _createdUserId = json['created_user_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _action = json['action'];
    _isDelete = json['is_delete'];
    _userTypeId = json['user_type_id'];
    _userTypeName = json['user_type_name'];
    _notes = json['notes'];
    _isActive = json['is_active'];
    _organization = json['organization'];
  }
  String? _id;
  int? _createdUserId;
  String? _createdDate;
  String? _updatedDate;
  String? _action;
  bool? _isDelete;
  int? _userTypeId;
  String? _userTypeName;
  String? _notes;
  bool? _isActive;
  String? _organization;
Data copyWith({  String? id,
  int? createdUserId,
  String? createdDate,
  String? updatedDate,
  String? action,
  bool? isDelete,
  int? userTypeId,
  String? userTypeName,
  String? notes,
  bool? isActive,
  String? organization,
}) => Data(  id: id ?? _id,
  createdUserId: createdUserId ?? _createdUserId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  action: action ?? _action,
  isDelete: isDelete ?? _isDelete,
  userTypeId: userTypeId ?? _userTypeId,
  userTypeName: userTypeName ?? _userTypeName,
  notes: notes ?? _notes,
  isActive: isActive ?? _isActive,
  organization: organization ?? _organization,
);
  String? get id => _id;
  int? get createdUserId => _createdUserId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get action => _action;
  bool? get isDelete => _isDelete;
  int? get userTypeId => _userTypeId;
  String? get userTypeName => _userTypeName;
  String? get notes => _notes;
  bool? get isActive => _isActive;
  String? get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_user_id'] = _createdUserId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['action'] = _action;
    map['is_delete'] = _isDelete;
    map['user_type_id'] = _userTypeId;
    map['user_type_name'] = _userTypeName;
    map['notes'] = _notes;
    map['is_active'] = _isActive;
    map['organization'] = _organization;
    return map;
  }

}