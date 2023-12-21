/// StatusCode : 6000
/// data : "Finances Successfully Deleted"

class DeleteTransferList {
  DeleteTransferList({
      num? statusCode, 
      String? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeleteTransferList.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    _data = json['data']??json["message"];
  }
  num? _statusCode;
  String? _data;
DeleteTransferList copyWith({  num? statusCode,
  String? data,
}) => DeleteTransferList(  statusCode: statusCode ?? _statusCode,
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