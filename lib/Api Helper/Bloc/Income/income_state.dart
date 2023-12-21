part of 'income_bloc.dart';

@immutable
abstract class IncomeState {}

class IncomeInitial extends IncomeState {}

class IncomeCreateLoading extends IncomeState {}
class IncomeCreateLoaded extends IncomeState {}
class IncomeCreateError extends IncomeState {}

class IncomeListLoading extends IncomeState {}
class IncomeListLoaded extends IncomeState {}
class IncomeListError extends IncomeState {}

class DetailIncomeLoading extends IncomeState {}
class DetailIncomeLoaded extends IncomeState {}
class DetailIncomeError extends IncomeState {}

class EditIncomeLoading extends IncomeState {}
class EditIncomeLoaded extends IncomeState {}
class EditIncomeError extends IncomeState {}

class DeleteIncomeLoading extends IncomeState {}
class DeleteIncomeLoaded extends IncomeState {}
class DeleteIncomeError extends IncomeState {}
