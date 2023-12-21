/// StatusCode : 6000
/// data : "Axix bank Successfully Deleted"

class DeleteAccountModel {
  DeleteAccountModel({
      num? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteAccountModel.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data'];
  }
  num? _statusCode;
  String? _data;
DeleteAccountModel copyWith({  num? statusCode,
  String? data,
}) => DeleteAccountModel(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    map['data'] = _data;
    return map;
  }

}