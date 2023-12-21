part of 'income_transaction_bloc.dart';

@immutable
abstract class IncomeTransactionEvent {}

class FetchIncomeTransactionEvent extends IncomeTransactionEvent {
  final String fromDate;
  final String toDate;

  FetchIncomeTransactionEvent({required this.fromDate, required this.toDate});

}

