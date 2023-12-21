part of 'income_transaction_bloc.dart';

@immutable
abstract class IncomeTransactionState {}

class IncomeTransactionInitial extends IncomeTransactionState {}

class IncomeTransactionLoading extends IncomeTransactionState {}
class IncomeTransactionLoaded extends IncomeTransactionState {}
class IncomeTransactionError extends IncomeTransactionState {}
