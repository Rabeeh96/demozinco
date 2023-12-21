part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}
class ExpenseCreateLoading extends ExpenseState {}
class ExpenseCreateLoaded extends ExpenseState {}
class ExpenseCreateError extends ExpenseState {}

class ExpenseListLoading extends ExpenseState {}
class ExpenseListLoaded extends ExpenseState {}
class ExpenseListError extends ExpenseState {}

class DetailExpenseLoading extends ExpenseState {}
class DetailExpenseLoaded extends ExpenseState {}
class DetailExpenseError extends ExpenseState {}

class EditExpenseLoading extends ExpenseState {}
class EditExpenseLoaded extends ExpenseState {}
class EditExpenseError extends ExpenseState {}

class DeleteExpenseLoading extends ExpenseState {}
class DeleteExpenseLoaded extends ExpenseState {}
class DeleteExpenseError extends ExpenseState {}
