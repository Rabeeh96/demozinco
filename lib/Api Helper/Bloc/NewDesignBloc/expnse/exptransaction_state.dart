part of 'exptransaction_bloc.dart';

@immutable
abstract class ExptransactionState {}

class ExptransactionInitial extends ExptransactionState {}

class ExpTransactionLoading extends ExptransactionState {}
class ExpTransactionLoaded extends ExptransactionState {}
class ExpTransactionError extends ExptransactionState {}

class FilterTransactionLoading extends ExptransactionState {}
class FilterTransactionLoaded extends ExptransactionState {}
class FilterTransactionError extends ExptransactionState {}
