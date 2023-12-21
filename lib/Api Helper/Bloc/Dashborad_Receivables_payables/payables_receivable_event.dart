part of 'payables_receivable_bloc.dart';

@immutable
abstract class PayablesReceivableEvent {}
class FetchPayablesReceivableListEvent extends PayablesReceivableEvent {
  final String filter;

  FetchPayablesReceivableListEvent({required this.filter});
}