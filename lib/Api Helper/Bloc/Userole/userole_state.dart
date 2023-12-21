part of 'userole_bloc.dart';

@immutable
abstract class UseroleState {}

class UseroleInitial extends UseroleState {}
class UseroleCreateLoading extends UseroleState {}
class UseroleCreateLoaded extends UseroleState {}
class UseroleCreateError extends UseroleState {}

class UseroleListSearchLoading extends UseroleState {}
class UseroleListSearchLoaded extends UseroleState {}
class UseroleListSearchError extends UseroleState {}
class DetailUseroleLoading extends UseroleState {}
class DetailUseroleLoaded extends UseroleState {}
class DetailUseroleError extends UseroleState {}
class EditUseroleLoading extends UseroleState {}
class EditUseroleLoaded extends UseroleState {}
class EditUseroleError extends UseroleState {}
class DeleteUseroleLoading extends UseroleState {}
class DeleteUseroleLoaded extends UseroleState {}
class DeleteUseroleError extends UseroleState {}
