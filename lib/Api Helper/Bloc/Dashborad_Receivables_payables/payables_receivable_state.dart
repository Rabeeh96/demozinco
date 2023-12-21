part of 'payables_receivable_bloc.dart';

@immutable
abstract class PayablesReceivableState {}

class PayablesReceivableInitial extends PayablesReceivableState {}
class PayablesReceivableListLoading extends PayablesReceivableState {}
class PayablesReceivableListLoaded extends PayablesReceivableState {}
class PayablesReceivableListError extends PayablesReceivableState {}
