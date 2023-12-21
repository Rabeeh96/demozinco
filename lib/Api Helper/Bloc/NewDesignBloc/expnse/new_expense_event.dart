part of 'new_expense_bloc.dart';

@immutable
abstract class NewExpenseEvent {}

class FetchNewExpenseOverviewEvent extends NewExpenseEvent {
  final String fromDate;
  final String toDate;
  final int pageNumber;
  final int pageSize;

  FetchNewExpenseOverviewEvent(
      {required this.fromDate,required this.toDate,required this.pageNumber,required this.pageSize});
}

class FetchNewExpenseDetailEvent extends NewExpenseEvent {
  final String accountId;
  final int pageNumber;
  final int pageSize;
  final String fromDate;
  final String toDate;

  FetchNewExpenseDetailEvent(
      {required this.accountId,required this.pageNumber,required this.pageSize,required  this.fromDate,
        required  this.toDate});
}



class FetchDeleteTransactionEvent extends NewExpenseEvent {
  final String id;

  FetchDeleteTransactionEvent(
      {required this.id});
}


