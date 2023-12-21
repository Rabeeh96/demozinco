part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionCreateLoading extends TransactionState {}
class TransactionCreateLoaded extends TransactionState {}
class TransactionCreateError extends TransactionState {}

class TransactionListLoading extends TransactionState {}
class TransactionListLoaded extends TransactionState {}
class TransactionListError extends TransactionState {}

class DetailTransactionLoading extends TransactionState {}
class DetailTransactionLoaded extends TransactionState {}
class DetailTransactionError extends TransactionState {}

class EditTransactionLoading extends TransactionState {}
class EditTransactionLoaded extends TransactionState {}
class EditTransactionError extends TransactionState {}

class DeleteTransactionLoading extends TransactionState {}
class DeleteTransactionLoaded extends TransactionState {}
class DeleteTransactionError extends TransactionState {}
