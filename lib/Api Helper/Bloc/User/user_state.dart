part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserCreateLoading extends UserState {}
class UserCreateLoaded extends UserState {}
class UserCreateError extends UserState {}

class UserListSearchLoading extends UserState {}
class UserListSearchLoaded extends UserState {}
class UserListSearchError extends UserState {}

class DetailUserLoading extends UserState {}
class DetailUserLoaded extends UserState {}
class DetailUserError extends UserState {}

class EditUserLoading extends UserState {}
class EditUserLoaded extends UserState {}
class EditUserError extends UserState {}

class DeleteUserLoading extends UserState {}
class DeleteUserLoaded extends UserState {}
class DeleteUserError extends UserState {}
