part of 'pagination_contact_bloc.dart';

@immutable
abstract class PaginationContactEvent {}
class InitialListEvent extends PaginationContactEvent{
  final String search;
  final String organisation;

  InitialListEvent({required this.search,required this.organisation});
}

class ListContactPaginationEvent extends PaginationContactEvent {
  final String organisation;
  final int page_number;
  final int page_size;
  final String search;

  ListContactPaginationEvent(
      {required this.organisation,
        required this.page_number,
        required this.page_size,
        required this.search});
}
