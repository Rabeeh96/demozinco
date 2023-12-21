part of 'zakath_interest_list_bloc.dart';

@immutable
abstract class ZakathInterestListState {}

class ZakathInterestListInitial extends ZakathInterestListState {}
class ZakathInterestListLoading extends ZakathInterestListState {}
class ZakathInterestListLoaded extends ZakathInterestListState {}
class ZakathInterestListError extends ZakathInterestListState {}


class ZakathInterestDetailListLoading extends ZakathInterestListState {}
class ZakathInterestDetailListLoaded extends ZakathInterestListState {}
class ZakathInterestDetailListError extends ZakathInterestListState {}