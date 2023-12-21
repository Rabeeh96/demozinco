part of 'zakath_interest_list_bloc.dart';

@immutable
abstract class ZakathInterestListEvent {}


class FetchInterestZakathListEvent extends ZakathInterestListEvent {
  final String filter;

  FetchInterestZakathListEvent({required this.filter});
}
class FetchInterestZakathDetailListEvent extends ZakathInterestListEvent {
  final String filter;
  final String id;
  final String fromDate;
  final String toDate;

  FetchInterestZakathDetailListEvent({required this.filter,required this.id,required this.fromDate,required this.toDate});
}