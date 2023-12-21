part of 'delete_user_bloc.dart';

@immutable
abstract class DeleteUserState {}

class DeleteUserInitial extends DeleteUserState {}
class DeleteUserLoading extends DeleteUserState {}
class DeleteUserLoaded extends DeleteUserState {}
class DeleteUserError extends DeleteUserState {}
