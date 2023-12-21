// import 'dart:convert';
//
// ListLoanModelClass listLoanModelClassFromJson(String str) => ListLoanModelClass.fromJson(json.decode(str));
// String listLoanModelClassToJson(ListLoanModelClass data) => json.encode(data.toJson());
// class ListLoanModelClass {
//   ListLoanModelClass({
//       int? statusCode,
//       List<Data>? data,
//         summary,
//   }){
//     _statusCode = statusCode;
//     _data = data;
//     _summary = summary;
// }
//
//   ListLoanModelClass.fromJson(dynamic json) {
//     _statusCode = json['StatusCode'];
//     _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//
//
//   }
//   int? _statusCode;
//   List<Data>? _data;
//   Summary ? _summary;
//
//   ListLoanModelClass copyWith({
//     int? statusCode,
//     List<Data>? data,
//     summary,
// }) => ListLoanModelClass(  statusCode: statusCode ?? _statusCode,
//   data: data ?? _data,
//     summary: summary ?? _summary
// );
//   int? get statusCode => _statusCode;
//   List<Data>? get data => _data;
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['StatusCode'] = _statusCode;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// String dataToJson(Data data) => json.encode(data.toJson());
//
// class Data {
//   Data({
//     this.id,
//     this.loanId,
//     this.date,
//     this.loanName,
//     this.loanAmount,
//     this.outstandingAmount,
//     this.paymentType,});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     loanId = json['loan_id'];
//     date = json['date'];
//     loanName = json['loan_name'];
//     loanAmount = json['loan_amount'].toString();
//     outstandingAmount = json['outstanding_amount'].toString();
//     paymentType = json['payment_type'];
//   }
//   String ? id;
//   int ? loanId;
//   String ? date;
//   String ? loanName;
//   String ? loanAmount;
//   String ? outstandingAmount;
//   String ? paymentType;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['loan_id'] = loanId;
//     map['date'] = date;
//     map['loan_name'] = loanName;
//     map['loan_amount'] = loanAmount;
//     map['outstanding_amount'] = outstandingAmount;
//     map['payment_type'] = paymentType;
//     return map;
//   }
//
// }
// class Summary {
//   Summary({
//     this.numbers,
//     this.totOutstanding,});
//
//   Summary.fromJson(dynamic json) {
//     numbers = json['numbers'];
//     totOutstanding = json['tot_outstanding'];
//   }
//   int ? numbers;
//   double ? totOutstanding;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['numbers'] = numbers;
//     map['tot_outstanding'] = totOutstanding;
//     return map;
//   }
//
// }
//
//


class ListLoanModelClass {
  ListLoanModelClass({
    this.statusCode,
    this.summary,
    this.data,});

  ListLoanModelClass.fromJson(dynamic json) {
    statusCode = json['StatusCode'];
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  int ? statusCode;
  Summary ? summary;
  List<Data> ? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = statusCode;
    if (summary != null) {
      map['summary'] = summary!.toJson();
    }
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Data {
  Data({
    this.id,
    this.loanId,
    this.date,
    this.loanName,
    this.loanAmount,
    this.loan_status,
    this.outstandingAmount,
    this.paymentType,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    loanId = json['loan_id'];
    date = json['date'];
    loanName = json['loan_name'];
    loan_status = json['loan_status'];
    loanAmount = json['loan_amount'].toString();
    outstandingAmount = json['outstanding_amount'].toString();
    paymentType = json['payment_type'];
  }
  String ?  id;
  int ?  loanId;
  String ?  date;
  String ?  loanName;
  String ?  loanAmount;
  String ?  outstandingAmount;
  String ?  loan_status;
  String ?  paymentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['loan_id'] = loanId;
    map['date'] = date;
    map['loan_name'] = loanName;
    map['loan_amount'] = loanAmount;
    map['outstanding_amount'] = outstandingAmount;
    map['loan_status'] = loan_status;
    map['payment_type'] = paymentType;
    return map;
  }

}


class Summary {
  Summary({
    this.numbers,
    this.totOutstanding,});

  Summary.fromJson(dynamic json) {
    numbers = json['numbers'];
    totOutstanding = json['tot_outstanding'].toString();
  }
  int ? numbers;
  String ? totOutstanding;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['numbers'] = numbers;
    map['tot_outstanding'] = totOutstanding;
    return map;
  }

}