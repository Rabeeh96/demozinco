part of 'transaction_contact_bloc.dart';

@immutable
abstract class TransactionContactState {}

class TransactionContactInitial extends TransactionContactState {}
class TransactionContactCreateLoading extends TransactionContactState {}
class TransactionContactCreateLoaded extends TransactionContactState {}
class TransactionContactCreateError extends TransactionContactState {}

class TransactionContactListLoading extends TransactionContactState {}
class TransactionContactListLoaded extends TransactionContactState {}
class TransactionContactListError extends TransactionContactState {}

class DetailTransactionContactLoading extends TransactionContactState {}
class DetailTransactionContactLoaded extends TransactionContactState {}
class DetailTransactionContactError extends TransactionContactState {}

class EditTransactionContactLoading extends TransactionContactState {}
class EditTransactionContactLoaded extends TransactionContactState {}
class EditTransactionContactError extends TransactionContactState {}

class DeleteTransactionContactLoading extends TransactionContactState {}
class DeleteTransactionContactLoaded extends TransactionContactState {}
class DeleteTransactionContactError extends TransactionContactState {}
