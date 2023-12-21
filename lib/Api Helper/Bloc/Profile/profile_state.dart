part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ChangePasswordLoading extends ProfileState {}
class ChangePasswordLoaded extends ProfileState {}
class ChangePasswordError extends ProfileState {}
class ChangeFirstNameLoading extends ProfileState {}
class ChangeFirstNameLoaded extends ProfileState {}
class ChangeFirstNameError extends ProfileState {}
class ChangeEmailLoading extends ProfileState {}
class ChangeEmailLoaded extends ProfileState {}
class ChangeEmailError extends ProfileState {}
class ChangeIsNotificationLoading extends ProfileState {}
class ChangeIsNotificationLoaded extends ProfileState {}
class ChangeIsNotificationError extends ProfileState {}
class ChangeIszakathLoading extends ProfileState {}
class ChangeIszakathLoaded extends ProfileState {}
class ChangeIszakathError extends ProfileState {}
class ChangeIsinterestLoading extends ProfileState {}
class ChangeIsinterestLoaded extends ProfileState {}
class ChangeIsinterestError extends ProfileState {}
class ChangeProfilePicLoading extends ProfileState {}
class ChangeProfilePicLoaded extends ProfileState {}
class ChangeProfilePicError extends ProfileState {}
class ChangeRoundingLoading extends ProfileState {}
class ChangeRoundingLoaded extends ProfileState {}
class ChangeRoundingError extends ProfileState {}


