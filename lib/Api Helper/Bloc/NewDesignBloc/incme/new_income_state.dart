part of 'new_income_bloc.dart';

@immutable
abstract class NewIncomeState {}

class NewIncomeInitial extends NewIncomeState {}

class IncomeOverviewLoading extends NewIncomeState {}
class IncomeOverviewLoaded extends NewIncomeState {}
class IncomeOverviewError extends NewIncomeState {}


class IncomeDetailLoading extends NewIncomeState {}
class IncomeDetailLoaded extends NewIncomeState {}
class IncomeDetailError extends NewIncomeState {}


