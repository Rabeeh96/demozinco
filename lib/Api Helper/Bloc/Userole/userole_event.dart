part of 'userole_bloc.dart';

@immutable
abstract class UseroleEvent {}
class CreateUseroleEvent extends UseroleEvent {
  final String organizationId;
  final String userTypeName;
  final String notes;
  final List permissionData;

  CreateUseroleEvent( {required this.organizationId,required this.userTypeName,required this.notes,required this.permissionData});


}

class ListUseroleGetEvent extends UseroleEvent {
  final String search;
  final int pageNo;
  final int items_per_page;

  ListUseroleGetEvent({required this.search,required this.pageNo,required this.items_per_page});
}
class DetailUseroleGetEvent extends UseroleEvent {
  final String id;
  DetailUseroleGetEvent({required this.id});
}
class EditUseroleGetEvent extends UseroleEvent {
  final String organisationId;
  final int userTypeId;
  final String userTypeName;
  final List permissionData;

  EditUseroleGetEvent(
      {required this.organisationId,
      required this.userTypeId,
      required this.userTypeName,
      required this.permissionData});
}
class DeleteUseroleGetEvent extends UseroleEvent {
  final String organisationId;
  final int userTypeId;

  DeleteUseroleGetEvent({required this.organisationId,required this.userTypeId});

}
