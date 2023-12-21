part of 'loan_bloc.dart';

@immutable
abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanCreateLoading extends LoanState {}
class LoanCreateLoaded extends LoanState {}
class LoanCreateError extends LoanState {}

class LoanListLoading extends LoanState {}
class LoanListLoaded extends LoanState {}
class LoanListError extends LoanState {}

class DetailLoanLoading extends LoanState {}
class DetailLoanLoaded extends LoanState {}
class DetailLoanError extends LoanState {}

class EditLoanLoading extends LoanState {}
class EditLoanLoaded extends LoanState {}
class EditLoanError extends LoanState {}

class DeleteLoanLoading extends LoanState {}
class DeleteLoanLoaded extends LoanState {}
class DeleteLoanError extends LoanState {}

class ViewLoanLoading extends LoanState {}
class ViewLoanLoaded extends LoanState {}
class ViewLoanError extends LoanState {}
