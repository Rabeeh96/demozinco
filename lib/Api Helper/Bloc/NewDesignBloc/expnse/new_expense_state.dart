part of 'new_expense_bloc.dart';

@immutable
abstract class NewExpenseState {}

class NewExpenseInitial extends NewExpenseState {}
class ExpenseOverviewLoading extends NewExpenseState {}
class ExpenseOverviewLoaded extends NewExpenseState {}
class ExpenseOverviewError extends NewExpenseState {}


class ExpenseDetailLoading extends NewExpenseState {}
class ExpenseDetailLoaded extends NewExpenseState {}
class ExpenseDetailError extends NewExpenseState {}




class ExpenseTransactionDeleteLoading extends NewExpenseState {}
class ExpenseTransactionDeleteLoaded extends NewExpenseState {}
class ExpenseTransactionDeleteError extends NewExpenseState {}

class ExpenseFilterLoading extends NewExpenseState {}
class ExpenseFilterLoaded extends NewExpenseState {}
class ExpenseFilterError extends NewExpenseState {}