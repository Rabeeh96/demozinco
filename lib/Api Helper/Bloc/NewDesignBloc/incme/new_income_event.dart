part of 'new_income_bloc.dart';

@immutable
abstract class NewIncomeEvent {}

class FetchNewIncomeOverviewEvent extends NewIncomeEvent {
  final String fromDate;
  final String toDate;
  final int pageNumber;
  final int pageSize;

  FetchNewIncomeOverviewEvent(
      {required this.fromDate,required this.toDate,required this.pageNumber,required this.pageSize});
}

class FetchNewIncomeDetailEvent extends NewIncomeEvent {
  final String accountId;
  final int pageNumber;
  final int pageSize;

  FetchNewIncomeDetailEvent(
      {required this.accountId,required this.pageNumber,required this.pageSize});
}


