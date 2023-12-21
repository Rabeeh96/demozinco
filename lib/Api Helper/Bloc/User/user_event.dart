part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}
class CreateUserEvent extends UserEvent {
  final String firstName;
  final String userName;
  final String email;
  final String passwordOne;
  final String passwordTwo;
  final String phone;
  final String userTypeId;
  final String organization_id;
  final String filePath;

  CreateUserEvent(
      {required this.firstName,
      required this.userName,
      required this.email,
      required this.passwordOne,
      required this.passwordTwo,
      required this.phone,
      required this.userTypeId,
      required this.organization_id,
        required this.filePath,
      });
}
class ListUserEvent extends UserEvent {
  final String search;
  ListUserEvent(
      {required this.search,
        });
}
class DetailUserEvent extends UserEvent {
  final int id;
  DetailUserEvent(
      {required this.id,
      });
}
class EditUserEvent extends UserEvent {
  final String firstName;
  final String userName;
  final String email;
  final String passwordOne;
  final String passwordTwo;
  final String phone;
  final String userTypeId;
  final String organization_id;
  final String id;
  final String filePath;

  EditUserEvent(
      {required this.firstName,
        required this.userName,
        required this.email,
        required this.passwordOne,
        required this.passwordTwo,
        required this.phone,
        required this.userTypeId,
        required this.organization_id,
        required this.filePath,
      required this.id});
}
class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(
      {required this.id,});
}
