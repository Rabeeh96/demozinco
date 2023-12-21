part of 'pagination_contact_bloc.dart';

@immutable
abstract class PaginationContactState {}

class PaginationContactInitial extends PaginationContactState {}
class ListPaginationContactLoading extends PaginationContactState {}

class ListPaginationContactLoaded extends PaginationContactState {}

class ListPaginationContactError extends PaginationContactState {}
