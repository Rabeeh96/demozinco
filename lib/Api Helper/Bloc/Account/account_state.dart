part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}
class CreateAccountLoading extends AccountState {}
class CreateAccountLoaded extends AccountState {}
class CreateAccountError extends AccountState {}
class ListAccountLoading extends AccountState {}
class ListAccountLoaded extends AccountState {}
class ListAccountError extends AccountState {}
class DetailAccountLoading extends AccountState {}
class DetailAccountLoaded extends AccountState {}
class DetailAccountError extends AccountState {}
class EditAccountLoading extends AccountState {}
class EditAccountLoaded extends AccountState {}
class EditAccountError extends AccountState {}
class DeleteAccountLoading extends AccountState {}
class DeleteAccountLoaded extends AccountState {}
class DeleteAccountError extends AccountState {}
