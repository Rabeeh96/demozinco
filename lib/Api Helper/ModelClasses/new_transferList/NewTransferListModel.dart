// // import 'dart:convert';
// //
// // /// StatusCode : 6000
// // /// data : [{"date":"2023-08-11","total":0.0,"data":[{"id":"689b2f0f-1c9f-434c-83b8-30f720befc4a","from_account":"Nashid bank","from_country":"India","from_amount":0.0,"to_account":"Bank","to_country":"India","to_amount":28.0,"description":"","time":"10:56:00"},{"id":"cbfbdb5c-6557-40b1-9816-b74f4644d1e0","from_account":"Bank","from_country":"India","from_amount":0.0,"to_account":"Nashid bank","to_country":"India","to_amount":0.0,"description":"","time":"10:55:00"},{"id":"ccaadede-d678-481b-b363-7613366c08d8","from_account":"SBI Bank","from_country":"India","from_amount":0.0,"to_account":"ICICI Bank","to_country":"India","to_amount":589.0,"description":"","time":"10:56:00"},{"id":"48cea9f0-aa28-44e4-aa3e-9000f64c7e6f","from_account":"SBI Bank","from_country":"India","from_amount":0.0,"to_account":"ICICI Bank","to_country":"India","to_amount":256.0,"description":"","time":"10:57:00"}]},{"date":"2023-08-12","total":0.0,"data":[{"id":"a9caf7d8-4d79-4896-97d9-e2d64f9fefa3","from_account":"SBI Bank","from_country":"India","from_amount":0.0,"to_account":"Nashid bank","to_country":"India","to_amount":250.0,"description":"","time":"10:55:00"}]}]
// //
// // NewTransferListModel transferModelClassFromJson(String str) => NewTransferListModel.fromJson(json.decode(str));
// //
// // String transferModelClassToJson(NewTransferListModel data) => json.encode(data.toJson());
// //
// // class NewTransferListModel {
// //   NewTransferListModel({
// //     int? statusCode,
// //     List<Data>? data,
// //   }) {
// //     _statusCode = statusCode;
// //     _data = data;
// //   }
// //
// //   NewTransferListModel.fromJson(dynamic json) {
// //     _statusCode = json['StatusCode'];
// //     if (json['data'] != null) {
// //       _data = [];
// //       json['data'].forEach((v) {
// //         _data?.add(Data.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   int? _statusCode;
// //   List<Data>? _data;
// //
// //   NewTransferListModel copyWith({
// //     int? statusCode,
// //     List<Data>? data,
// //   }) =>
// //       NewTransferListModel(
// //         statusCode: statusCode ?? _statusCode,
// //         data: data ?? _data,
// //       );
// //
// //   int? get statusCode => _statusCode;
// //
// //   List<Data>? get data => _data;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['StatusCode'] = _statusCode;
// //     if (_data != null) {
// //       map['data'] = _data?.map((v) => v.toJson()).toList();
// //     }
// //     return map;
// //   }
// // }
// //
// // /// date : "2023-08-11"
// // /// total : 0.0
// // /// data : [{"id":"689b2f0f-1c9f-434c-83b8-30f720befc4a","from_account":"Nashid bank","from_country":"India","from_amount":0.0,"to_account":"Bank","to_country":"India","to_amount":28.0,"description":"","time":"10:56:00"},{"id":"cbfbdb5c-6557-40b1-9816-b74f4644d1e0","from_account":"Bank","from_country":"India","from_amount":0.0,"to_account":"Nashid bank","to_country":"India","to_amount":0.0,"description":"","time":"10:55:00"},{"id":"ccaadede-d678-481b-b363-7613366c08d8","from_account":"SBI Bank","from_country":"India","from_amount":0.0,"to_account":"ICICI Bank","to_country":"India","to_amount":589.0,"description":"","time":"10:56:00"},{"id":"48cea9f0-aa28-44e4-aa3e-9000f64c7e6f","from_account":"SBI Bank","from_country":"India","from_amount":0.0,"to_account":"ICICI Bank","to_country":"India","to_amount":256.0,"description":"","time":"10:57:00"}]
// //
// // Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// //
// // String dataToJson(Data data) => json.encode(data.toJson());
// //
// // class Data {
// //   Data({
// //     String? date,
// //     double? total,
// //     List<Data>? data,
// //   }) {
// //     _date = date;
// //     _total = total;
// //     _data = data;
// //   }
// //
// //   Data.fromJson(dynamic json) {
// //     _date = json['date'];
// //     _total = json['total'];
// //     if (json['data'] != null) {
// //       _data = [];
// //       json['data'].forEach((v) {
// //         _data?.add(Data.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   String? _date;
// //   double? _total;
// //   List<Data>? _data;
// //
// //   Data copyWith({
// //     String? date,
// //     double? total,
// //     List<Data>? data,
// //   }) =>
// //       Data(
// //         date: date ?? _date,
// //         total: total ?? _total,
// //         data: data ?? _data,
// //       );
// //
// //   String? get date => _date;
// //
// //   double? get total => _total;
// //
// //   List<Data>? get data => _data;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['date'] = _date;
// //     map['total'] = _total;
// //     if (_data != null) {
// //       map['data'] = _data?.map((v) => v.toJson()).toList();
// //     }
// //     return map;
// //   }
// // }
// //
// // /// id : "689b2f0f-1c9f-434c-83b8-30f720befc4a"
// // /// from_account : "Nashid bank"
// // /// from_country : "India"
// // /// from_amount : 0.0
// // /// to_account : "Bank"
// // /// to_country : "India"
// // /// to_amount : 28.0
// // /// description : ""
// // /// time : "10:56:00"
// //
// // Data dataDetailFromJson(String str) => Data.fromJson(json.decode(str));
// //
// // String dataDetailToJson(Data data) => json.encode(data.toJson());
// //
// // class DataDetail {
// //   DataDetail({
// //     String? id,
// //     String? fromAccount,
// //     String? fromCountry,
// //     double? fromAmount,
// //     String? toAccount,
// //     String? toCountry,
// //     double? toAmount,
// //     String? description,
// //     String? time,
// //   }) {
// //     _id = id;
// //     _fromAccount = fromAccount;
// //     _fromCountry = fromCountry;
// //     _fromAmount = fromAmount;
// //     _toAccount = toAccount;
// //     _toCountry = toCountry;
// //     _toAmount = toAmount;
// //     _description = description;
// //     _time = time;
// //   }
// //
// //   DataDetail.fromJson(dynamic json) {
// //     _id = json['id'];
// //     _fromAccount = json['from_account'];
// //     _fromCountry = json['from_country'];
// //     _fromAmount = json['from_amount'];
// //     _toAccount = json['to_account'];
// //     _toCountry = json['to_country'];
// //     _toAmount = json['to_amount'];
// //     _description = json['description'];
// //     _time = json['time'];
// //   }
// //
// //   String? _id;
// //   String? _fromAccount;
// //   String? _fromCountry;
// //   double? _fromAmount;
// //   String? _toAccount;
// //   String? _toCountry;
// //   double? _toAmount;
// //   String? _description;
// //   String? _time;
// //
// //   DataDetail copyWith({
// //     String? id,
// //     String? fromAccount,
// //     String? fromCountry,
// //     double? fromAmount,
// //     String? toAccount,
// //     String? toCountry,
// //     double? toAmount,
// //     String? description,
// //     String? time,
// //   }) =>
// //       DataDetail(
// //         id: id ?? _id,
// //         fromAccount: fromAccount ?? _fromAccount,
// //         fromCountry: fromCountry ?? _fromCountry,
// //         fromAmount: fromAmount ?? _fromAmount,
// //         toAccount: toAccount ?? _toAccount,
// //         toCountry: toCountry ?? _toCountry,
// //         toAmount: toAmount ?? _toAmount,
// //         description: description ?? _description,
// //         time: time ?? _time,
// //       );
// //
// //   String? get id => _id;
// //
// //   String? get fromAccount => _fromAccount;
// //
// //   String? get fromCountry => _fromCountry;
// //
// //   double? get fromAmount => _fromAmount;
// //
// //   String? get toAccount => _toAccount;
// //
// //   String? get toCountry => _toCountry;
// //
// //   double? get toAmount => _toAmount;
// //
// //   String? get description => _description;
// //
// //   String? get time => _time;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['id'] = _id;
// //     map['from_account'] = _fromAccount;
// //     map['from_country'] = _fromCountry;
// //     map['from_amount'] = _fromAmount;
// //     map['to_account'] = _toAccount;
// //     map['to_country'] = _toCountry;
// //     map['to_amount'] = _toAmount;
// //     map['description'] = _description;
// //     map['time'] = _time;
// //     return map;
// //   }
// // }
//
//
//
// class TransferDataModel {
//   int? statusCode;
//   List<Data>? data;
//
//   TransferDataModel({this.statusCode, this.data});
//
//   TransferDataModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['StatusCode'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['StatusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? date;
//   int? total;
//   List<Data>? data;
//
//   Data({this.date, this.total, this.data});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     total = json['total'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['total'] = this.total;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? fromAccount;
//   String? fromCountry;
//   int? fromAmount;
//   String? toAccount;
//   String? toCountry;
//   int? toAmount;
//   String? description;
//   String? time;
//
//   Data(
//       {this.id,
//         this.fromAccount,
//         this.fromCountry,
//         this.fromAmount,
//         this.toAccount,
//         this.toCountry,
//         this.toAmount,
//         this.description,
//         this.time});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fromAccount = json['from_account'];
//     fromCountry = json['from_country'];
//     fromAmount = json['from_amount'];
//     toAccount = json['to_account'];
//     toCountry = json['to_country'];
//     toAmount = json['to_amount'];
//     description = json['description'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['from_account'] = this.fromAccount;
//     data['from_country'] = this.fromCountry;
//     data['from_amount'] = this.fromAmount;
//     data['to_account'] = this.toAccount;
//     data['to_country'] = this.toCountry;
//     data['to_amount'] = this.toAmount;
//     data['description'] = this.description;
//     data['time'] = this.time;
//     return data;
//   }
// }
// class TransferDataModel {
//   int? statusCode;
//   List<Data>? data;
//
//   TransferDataModel({this.statusCode, this.data});
//
//   TransferDataModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['StatusCode'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['StatusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? date;
//   int? total;
//   List<Data>? data;
//
//   Data({this.date, this.total, this.data});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     total = json['total'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['total'] = this.total;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? fromAccount;
//   String? fromCountry;
//   int? fromAmount;
//   String? toAccount;
//   String? toCountry;
//   int? toAmount;
//   String? description;
//   String? time;
//
//   Data(
//       {this.id,
//         this.fromAccount,
//         this.fromCountry,
//         this.fromAmount,
//         this.toAccount,
//         this.toCountry,
//         this.toAmount,
//         this.description,
//         this.time});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fromAccount = json['from_account'];
//     fromCountry = json['from_country'];
//     fromAmount = json['from_amount'];
//     toAccount = json['to_account'];
//     toCountry = json['to_country'];
//     toAmount = json['to_amount'];
//     description = json['description'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['from_account'] = this.fromAccount;
//     data['from_country'] = this.fromCountry;
//     data['from_amount'] = this.fromAmount;
//     data['to_account'] = this.toAccount;
//     data['to_country'] = this.toCountry;
//     data['to_amount'] = this.toAmount;
//     data['description'] = this.description;
//     data['time'] = this.time;
//     return data;
//   }
// }
