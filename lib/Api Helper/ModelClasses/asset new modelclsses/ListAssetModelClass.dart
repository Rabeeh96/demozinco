import 'dart:convert';
/// StatusCode : 6000
/// summary : {"count":3,"total_value":3709.0}
/// data : [{"id":"db684302-7485-4502-bce9-6b3620e72d6d","asset_master_id":2,"asset_name":"Test","photo":"/media/images/images.jpg","asset_type":"0"},null]

ListAssetModelClass listAssetModelClassFromJson(String str) => ListAssetModelClass.fromJson(json.decode(str));
String listAssetModelClassToJson(ListAssetModelClass data) => json.encode(data.toJson());
class ListAssetModelClass {
  ListAssetModelClass({
      int? statusCode, 
      Summary? summary, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _summary = summary;
    _data = data;
}

  ListAssetModelClass.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  Summary? _summary;
  List<Data>? _data;
ListAssetModelClass copyWith({  int? statusCode,
  Summary? summary,
  List<Data>? data,
}) => ListAssetModelClass(  statusCode: statusCode ?? _statusCode,
  summary: summary ?? _summary,
  data: data ?? _data,
);
  int? get statusCode => _statusCode;
  Summary? get summary => _summary;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "db684302-7485-4502-bce9-6b3620e72d6d"
/// asset_master_id : 2
/// asset_name : "Test"
/// photo : "/media/images/images.jpg"
/// asset_type : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      int? assetMasterId, 
      String? assetName, 
      String? photo, 
      String? assetType,
      String? state,
  }){
    _id = id;
    _assetMasterId = assetMasterId;
    _assetName = assetName;
    _photo = photo;
    _assetType = assetType;
    _state = state;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _assetMasterId = json['asset_master_id'];
    _assetName = json['asset_name'];
    _photo = json['photo']?? "";
    _assetType = json['asset_type'];
    _state = json['state']?? "";
  }
  String? _id;
  int? _assetMasterId;
  String? _assetName;
  String? _photo;
  String? _assetType;
  String? _state;
Data copyWith({  String? id,
  int? assetMasterId,
  String? assetName,
  String? photo,
  String? assetType,
  String? state,
}) => Data(  id: id ?? _id,
  assetMasterId: assetMasterId ?? _assetMasterId,
  assetName: assetName ?? _assetName,
  photo: photo ?? _photo,
  assetType: assetType ?? _assetType,
  state: state ?? _state,
);
  String? get id => _id;
  int? get assetMasterId => _assetMasterId;
  String? get assetName => _assetName;
  String? get photo => _photo;
  String? get assetType => _assetType;
  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_master_id'] = _assetMasterId;
    map['asset_name'] = _assetName;
    map['photo'] = _photo;
    map['asset_type'] = _assetType;
    map['state'] = _state;
    return map;
  }

}

/// count : 3
/// total_value : 3709.0

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
      String? count,
      String? totalValue,}){
    _count = count;
    _totalValue = totalValue;
}

  Summary.fromJson(dynamic json) {
    _count = json['count'].toString();
    _totalValue = json['total_value'].toString();
  }
  String? _count;
  String? _totalValue;
Summary copyWith({  String? count,
  String? totalValue,
}) => Summary(  count: count ?? _count,
  totalValue: totalValue ?? _totalValue,
);
  String? get count => _count;
  String? get totalValue => _totalValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['total_value'] = _totalValue;
    return map;
  }

}