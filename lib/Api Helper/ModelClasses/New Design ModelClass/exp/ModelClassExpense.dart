import 'dart:convert';
/// StatusCode : 6000
/// data : [{"id":"52f1b116-3b8a-4bf4-a971-adc9455ca7a2","accounts_id":31,"account_name":"My expe","balance":254.0},{"id":"4b5185bd-e724-4b9b-9207-b150b1287d2a","accounts_id":38,"account_name":"Ecp","balance":0},{"id":"b87df034-fba0-4a17-9b08-f42a6f2b6c36","accounts_id":39,"account_name":"Logic","balance":0},{"id":"7bbe8096-36c8-41dd-b643-2054454f8edc","accounts_id":41,"account_name":"Yt","balance":0},{"id":"e789690c-dc09-4d04-84b4-ccce91ba5410","accounts_id":42,"account_name":"Hi","balance":0},{"id":"e7e59552-4ac4-4c35-b673-64b4e6b3379f","accounts_id":40,"account_name":"Tallys","balance":0}]
/// summary : {"total":254.0,"this_month":254.0}
/// graph_data : [{"account_name":"My expe","amount":254.0},{"account_name":"Ecp","amount":0},{"account_name":"Logic","amount":0},{"account_name":"Yt","amount":0},{"account_name":"Others","balance":0}]
/// count : 6
/// current_page : 1
/// total_pages : 1
/// next_page : null
/// previous_page : null

ModelClassExpense modelClassExpenseFromJson(String str) => ModelClassExpense.fromJson(json.decode(str));
String modelClassExpenseToJson(ModelClassExpense data) => json.encode(data.toJson());
class ModelClassExpense {
  ModelClassExpense({
      int? statusCode, 
      List<Data>? data, 
      Summary? summary, 
      List<GraphData>? graphData, 
      int? count, 
      int? currentPage, 
      int? totalPages, 
      dynamic nextPage, 
      dynamic previousPage,}){
    _statusCode = statusCode;
    _data = data;
    _summary = summary;
    _graphData = graphData;
    _count = count;
    _currentPage = currentPage;
    _totalPages = totalPages;
    _nextPage = nextPage;
    _previousPage = previousPage;
}

  ModelClassExpense.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['graph_data'] != null) {
      _graphData = [];
      json['graph_data'].forEach((v) {
        _graphData?.add(GraphData.fromJson(v));
      });
    }
    _count = json['count'];
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _nextPage = json['next_page'];
    _previousPage = json['previous_page'];
  }
  int? _statusCode;
  List<Data>? _data;
  Summary? _summary;
  List<GraphData>? _graphData;
  int? _count;
  int? _currentPage;
  int? _totalPages;
  dynamic _nextPage;
  dynamic _previousPage;
ModelClassExpense copyWith({  int? statusCode,
  List<Data>? data,
  Summary? summary,
  List<GraphData>? graphData,
  int? count,
  int? currentPage,
  int? totalPages,
  dynamic nextPage,
  dynamic previousPage,
}) => ModelClassExpense(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
  summary: summary ?? _summary,
  graphData: graphData ?? _graphData,
  count: count ?? _count,
  currentPage: currentPage ?? _currentPage,
  totalPages: totalPages ?? _totalPages,
  nextPage: nextPage ?? _nextPage,
  previousPage: previousPage ?? _previousPage,
);
  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  Summary? get summary => _summary;
  List<GraphData>? get graphData => _graphData;
  int? get count => _count;
  int? get currentPage => _currentPage;
  int? get totalPages => _totalPages;
  dynamic get nextPage => _nextPage;
  dynamic get previousPage => _previousPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    if (_graphData != null) {
      map['graph_data'] = _graphData?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    map['current_page'] = _currentPage;
    map['total_pages'] = _totalPages;
    map['next_page'] = _nextPage;
    map['previous_page'] = _previousPage;
    return map;
  }

}

/// account_name : "My expe"
/// amount : 254.0

GraphData graphDataFromJson(String str) => GraphData.fromJson(json.decode(str));
String graphDataToJson(GraphData data) => json.encode(data.toJson());
class GraphData {
  GraphData({
      String? accountName, 
      String? amount,}){
    _accountName = accountName;
    _amount = amount;
}

  GraphData.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _amount = json['amount'].toString();
  }
  String? _accountName;
  String? _amount;
GraphData copyWith({  String? accountName,
  String? amount,
}) => GraphData(  accountName: accountName ?? _accountName,
  amount: amount ?? _amount,
);
  String? get accountName => _accountName;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['amount'] = _amount;
    return map;
  }

}

/// total : 254.0
/// this_month : 254.0

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
    String? total,
      String? thisMonth,}){
    _total = total;
    _thisMonth = thisMonth;
}

  Summary.fromJson(dynamic json) {
    _total = json['total'].toString();
    _thisMonth = json['this_month'].toString();
  }
  String? _total;
  String? _thisMonth;
Summary copyWith({  String? total,
  String? thisMonth,
}) => Summary(  total: total ?? _total,
  thisMonth: thisMonth ?? _thisMonth,
);
  String? get total => _total;
  String? get thisMonth => _thisMonth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['this_month'] = _thisMonth;
    return map;
  }

}

/// id : "52f1b116-3b8a-4bf4-a971-adc9455ca7a2"
/// accounts_id : 31
/// account_name : "My expe"
/// balance : 254.0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      int? accountsId, 
      String? accountName, 
      String? balance,}){
    _id = id;
    _accountsId = accountsId;
    _accountName = accountName;
    _balance = balance;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _accountsId = json['accounts_id'];
    _accountName = json['account_name'];
    _balance = json['balance'].toString();
  }
  String? _id;
  int? _accountsId;
  String? _accountName;
  String? _balance;
Data copyWith({  String? id,
  int? accountsId,
  String? accountName,
  String? balance,
}) => Data(  id: id ?? _id,
  accountsId: accountsId ?? _accountsId,
  accountName: accountName ?? _accountName,
  balance: balance ?? _balance,
);
  String? get id => _id;
  int? get accountsId => _accountsId;
  String? get accountName => _accountName;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['accounts_id'] = _accountsId;
    map['account_name'] = _accountName;
    map['balance'] = _balance;
    return map;
  }

}