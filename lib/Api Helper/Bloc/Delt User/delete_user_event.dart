part of 'delete_user_bloc.dart';

@immutable
abstract class DeleteUserEvent {}

class FetchDeleteUser extends DeleteUserEvent{
  final int userId;
  final String password;

  FetchDeleteUser({required this.userId,required this.password});
}
